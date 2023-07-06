# frozen_string_literal: true

require "elasticsearch/model"

# TODO: Move `include` into module
# rubocop:disable Style/MixinUsage
include SearchAnalyzer
# rubocop:enable Style/MixinUsage

module SearchableDirectory
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include SearchableCallbacks

    index_name [Rails.application.engine_name, Rails.env, "directory"].join("_")

    ### Custom settings and mappings
    settings(
      index: { number_of_shards: 1, number_of_replicas: 0 },
      analysis: SearchAnalyzer.analyzers
    ) do
      mappings do
        indexes :name, type: :string, analyzer: :edge_autocomplete_index, search_analyzer: :autocomplete_search,
                       fields: { raw: { type: :string, analyzer: :custom_standard } }
        indexes :parent_id, index: :not_analyzed
      end
    end

    ### custom serialization
    def as_indexed_json(_options = {})
      ## due to custom as_json in tag.rb
      as_json(only: %i[name customer_id parent_id])
    end

    def self.import_to_es
      Directory.__elasticsearch__.create_index! force: true
      Directory.import
    end

    ### Search method
    # TODO: Break down `query` into smaller private methods
    # rubocop:disable Metrics/MethodLength
    def self.search(term, current_customer, body = {}, options = {})
      search_definition = {
        query: {
          bool: {
            filter: {
              term: {
                customer_id: current_customer.id
              }
            },
            must: {
              dis_max: {
                tie_breaker: 0.7,
                boost: 1.2,
                queries: [
                  {
                    multi_match: {
                      query: term,
                      fields: ["name", "name.raw"],
                      type: :most_fields
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

    # TODO: Reduce `query` into smaller private methods
    # rubocop:disable Metrics/MethodLength
    def self.search_list(term, customer)
      __elasticsearch__.search(size: 10_000,
                               query: {
                                 bool: {
                                   filter: {
                                     term: {
                                       customer_id: customer.id
                                     }
                                   },
                                   must: {
                                     dis_max: {
                                       tie_breaker: 0.7,
                                       boost: 1.2,
                                       queries: [
                                         {
                                           match: {
                                             name: {
                                               query: term,
                                               fuzziness: :auto,
                                               boost: 10
                                             }
                                           }
                                         }
                                       ]
                                     }
                                   }
                                 }
                               }).records
    end
    # rubocop:enable Metrics/MethodLength

    def self.search_all(term, customer)
      search(term, customer, {}, size: 10_000).records
    end
  end
end
