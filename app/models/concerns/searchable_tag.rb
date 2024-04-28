# frozen_string_literal: true

require "elasticsearch/model"
require "jbuilder"

# TODO: Move `include` into module
# rubocop:disable Style/MixinUsage
include SearchAnalyzer
# rubocop:enable Style/MixinUsage

module SearchableTag
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include SearchableCallbacks

    index_name ["qualipso_application", Rails.env, "tag"].join("_")

    ### Custom settings and mappings
    settings(
      index: { number_of_shards: 1, number_of_replicas: 0 },
      analysis: SearchAnalyzer.analyzers
    ) do
      mappings do
        indexes :label, type: :string, analyzer: :autocomplete_index,
                        search_analyzer: :autocomplete_search,
                        fields: { raw: { type: :string, analyzer: :custom_standard } }
        indexes :suggest_tag, type: :completion, analyzer: :simple,
                              payloads: true,
                              context: {
                                customer_id: {
                                  type: :category,
                                  path: :customer_id
                                }
                              }
      end
    end

    ### custom serialization
    def as_indexed_json(_options = {})
      ## due to custom as_json in tag.rb
      {
        id: id,
        label: label,
        customer_id: customer_id,
        suggest_tag: {
          input: label,
          payload: {
            tagId: id
          },
          context: {
            customer_id: customer_id
          }
        }
      }
    end

    def self.import_to_es
      Tag.__elasticsearch__.create_index! force: true
      Tag.import
    end

    def self.suggest(query, customer)
      suggest_definition = {
        text: query,
        completion: {
          field: :suggest_tag,
          size: 50,
          context: {
            customer_id: customer.id
          }
        }
      }

      __elasticsearch__.client.suggest(index: index_name,
                                       body: {
                                         autocomplete_tag: suggest_definition
                                       })
    end

    ### Search methods
    # TODO: Refactor `self.search` into smaller private methods
    # rubocop:disable Metrics/MethodLength
    def self.search(term, current_customer, _body = {}, options = {})
      ## Elasticsearch query with jbuilder

      search_definition = {
        query: {
          bool: {
            filter: {
              bool: {
                must: [{ term: { customer_id: current_customer.id } }]
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
                      fields: ["label", "label.raw"],
                      type: :most_fields
                    }
                  }
                ]
              }
            }
          }
        }
      }
      search_definition.deep_merge!(options)

      __elasticsearch__.search(search_definition)
    end
    # rubocop:enable Metrics/MethodLength
  end
end
