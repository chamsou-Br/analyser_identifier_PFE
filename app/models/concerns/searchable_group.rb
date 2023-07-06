# frozen_string_literal: true

require "elasticsearch/model"

# TODO: Move `include` into module
# rubocop:disable Style/MixinUsage
include SearchAnalyzer
# rubocop:enable Style/MixinUsage

module SearchableGroup
  extend ActiveSupport::Concern
  include SearchableCallbacks
  include SearchableRecord

  included do
    include Elasticsearch::Model
    ## to ensure that future import will be on the same index
    index_name [Rails.application.engine_name, Rails.env, "group"].join("_")

    # #custom index configuration
    settings(
      index: { number_of_shards: 1, number_of_replicas: 0 },
      analysis: SearchAnalyzer.analyzers
    ) do
      ## custom mapping
      mappings do
        indexes :title,
                type: :string,
                analyzer: :edge_autocomplete_index,
                search_analyzer: :autocomplete_search,
                fields: { raw: { type: :string, analyzer: :custom_standard } }

        indexes :description,
                type: :string,
                analyzer: :edge_autocomplete_index,
                search_analyzer: :autocomplete_search,
                fields: { raw: { type: :string, analyzer: :custom_standard } }
      end
    end

    # Default search query for searching groups with the specified term.
    #
    # @param [String] term
    # @return [Hash] ElasticSearch query
    #
    def self.default_search_query(term)
      {
        bool: {
          should: search_queries(term)
        }
      }
    end

    def self.search_queries(term)
      [
        {
          multi_match: {
            query: term,
            fields: ["title", "title.raw"],
            type: :most_fields,
            boost: 10
          }
        },
        {
          multi_match: {
            query: term,
            fields: ["description", "description.raw"],
            type: :most_fields,
            boost: 5
          }
        }
      ]
    end

    def as_indexed_json(_options = {})
      as_json(only: %i[id title description customer_id])
    end

    ### Indexing and importing all the data to elasticsearch
    def self.import_to_es
      Group.__elasticsearch__.create_index! force: true
      Group.import
    end

    ### search method
    # TODO: Refactor `self.search` into smaller private methods
    # rubocop:disable Metrics/MethodLength
    #
    # TODO: verify if this method is used. It might not be after the new user
    # module is implemented.
    # TODO: write test for this method if method is needed.
    #
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
                      fields: ["title", "title.raw"],
                      boost: 10,
                      type: :most_fields
                    }
                  },
                  {
                    multi_match: {
                      query: term,
                      fields: ["description", "description.raw"],
                      boost: 5,
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

    # TODO: Extract `query` from `self.search_list` into smaller private method
    # rubocop:disable Metrics/MethodLength
    #
    # TODO: verify if this method is used. It might not be after the new user
    # module is implemented.
    # TODO: write test for this method if method is needed.
    #
    def self.search_list(term, customer)
      __elasticsearch__.search(
        size: 10_000,
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
                    multi_match: {
                      query: term,
                      fields: ["title", "title.raw"],
                      type: :most_fields,
                      boost: 1,
                      fuzziness: :auto
                    }
                  },
                  {
                    multi_match: {
                      query: term,
                      fields: ["description", "description.raw"],
                      boost: 5
                    }
                  }
                ]
              }
            }
          }
        }
      ).records
    end
    # rubocop:enable Metrics/MethodLength

    # TODO: verify if this method is used. It might not be after the new user
    # module is implemented.
    # TODO: write test for this method if method is needed.
    #
    def self.search_all(term, customer)
      search(term, customer, {}, size: 10_000).records
    end
  end
end
