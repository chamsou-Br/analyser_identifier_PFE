# frozen_string_literal: true

require "elasticsearch/model"

# TODO: Move `include` into module
# rubocop:disable Style/MixinUsage
include SearchAnalyzer
# rubocop:enable Style/MixinUsage

# TODO: Refactor `SearchableResource` into smaller inheriting classes/modules
module SearchableResource
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include SearchableCallbacks

    index_name [Rails.application.engine_name, Rails.env, "resource"].join("_")

    ### Custom settings and mappings
    settings(
      index: { number_of_shards: 1, number_of_replicas: 0 },
      analysis: SearchAnalyzer.analyzers
    ) do
      mappings do
        indexes :title, type: :string, analyzer: :autocomplete_index,
                        search_analyzer: :autocomplete_search,
                        fields: { raw: { type: :string, analyzer: :custom_standard } }
        indexes :purpose, type: :string, analyzer: :paragraph_analyzer
        indexes :resource_type, type: :string, analyzer: :custom_standard,
                                fields: { autocomplete: { type: :string,
                                                          analyzer: :edge_autocomplete_index,
                                                          search_analyzer: :autocomplete_search } }
        indexes :url, type: :string, analyzer: :standard
      end
    end

    ### custom serialization
    def as_indexed_json(_options = {})
      ## due to custom as_json in tag.rb
      as_json(only: %i[title resource_type purpose url customer_id deactivated])
    end

    def self.import_to_es
      Resource.__elasticsearch__.create_index! force: true
      Resource.import
    end

    def self.filter(current_user)
      filter = {
        bool: {
          must: [{ term: { customer_id: current_user.customer.id } }]
        }
      }

      filter[:bool][:must] << { term: { deactivated: false } } if current_user.process_user?

      filter
    end

    ### Search method
    # TODO: Refactor `self.search` into smaller private methods
    # rubocop:disable Metrics/MethodLength
    def self.search(term, current_user, body = {}, options = {})
      search_definition = {
        query: {
          bool: {
            filter: filter(current_user),
            must: {
              dis_max: {
                tie_breaker: 0.7,
                boost: 1.2,
                queries: [
                  {
                    multi_match: {
                      query: term,
                      fields: ["title", "title.raw"],
                      type: :most_fields,
                      fuzziness: :auto,
                      boost: 10
                    }
                  },
                  {
                    match: {
                      purpose: {
                        query: term,
                        boost: 5
                      }
                    }
                  },
                  {
                    match: {
                      url: {
                        query: term,
                        boost: 2
                      }
                    }
                  },
                  {
                    match: {
                      resource_type: {
                        query: term,
                        boost: 5
                      }
                    }
                  }
                ]
              }
            }
          }
        }
      }

      search_definition.merge!(options)
      search_definition[:query].merge!(body)

      __elasticsearch__.search(search_definition)
    end
    # rubocop:enable Metrics/MethodLength

    # TODO: Refactor `self.search_list` into smaller private methods
    # rubocop:disable Metrics/MethodLength
    def self.search_list(term, current_user)
      __elasticsearch__.search(size: 10_000,
                               query: {
                                 bool: {
                                   filter: filter(current_user),
                                   must: {
                                     dis_max: {
                                       tie_breaker: 0.7,
                                       boost: 1.2,
                                       queries: [
                                         {
                                           multi_match: {
                                             query: term,
                                             fields: ["title", "title.raw"],
                                             type: :most_fields,
                                             fuzziness: :auto,
                                             boost: 10
                                           }
                                         },
                                         {
                                           multi_match: {
                                             query: term,
                                             fields: ["resource_type", "resource_type.autocomplete"],
                                             boost: 5
                                           }
                                         }
                                       ]
                                     }
                                   }
                                 }
                               }).records
    end
    # rubocop:enable Metrics/MethodLength

    def self.search_all(term, current_user)
      search(term, current_user, {}, size: 10_000).records
    end
  end
end
