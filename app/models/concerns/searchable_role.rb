# frozen_string_literal: true

require "elasticsearch/model"

# TODO: Move `include` into module
# rubocop:disable Style/MixinUsage
include SearchAnalyzer
# rubocop:enable Style/MixinUsage

module SearchableRole
  extend ActiveSupport::Concern
  include SearchableRecord

  included do
    ### Custom settings and mappings
    settings(
      index: { number_of_shards: 1, number_of_replicas: 0 },
      analysis: SearchAnalyzer.analyzers
    ) do
      mappings do
        indexes :title, type: :string, analyzer: :autocomplete_index, search_analyzer: :autocomplete_search,
                        fields: { raw: { type: :string, analyzer: :custom_standard } }
        indexes :mission, type: :string, analyzer: :paragraph_analyzer
        indexes :purpose, type: :string, analyzer: :paragraph_analyzer
        indexes :activities, type: :string, analyzer: :paragraph_analyzer
      end
    end

    ### custom serialization
    def as_indexed_json(_options = {})
      as_json(only: %i[id title mission activities purpose type customer_id
                       deactivated])
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
                      boost: 10
                    }
                  },
                  {
                    match: {
                      mission: {
                        query: term,
                        boost: 5,
                        fuzziness: :auto
                      }
                    }
                  },
                  {
                    match: {
                      activities: {
                        query: term,
                        boost: 5,
                        fuzziness: :auto
                      }
                    }
                  },
                  {
                    match: {
                      purpose: {
                        query: term,
                        boost: 5,
                        fuzziness: :auto
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
                                             boost: 1
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

    ##
    # Default search query for searching roles with the specified term.
    #
    # @param [String] term
    # @return [Hash] ElasticSearch query
    #
    def self.default_search_query(term)
      {
        bool: {
          should: [
            multi_match(term, boost: 10, fields: %w[title title.raw]),
            multi_match(term, boost: 5,
                              fields: %w[mission activities purpose],
                              fuzziness: :auto)
          ]
        }
      }
    end
  end
end
