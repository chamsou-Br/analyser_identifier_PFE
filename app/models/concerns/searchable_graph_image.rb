# frozen_string_literal: true

require "elasticsearch/model"
require "jbuilder"

# TODO: Move `include` into module
# rubocop:disable Style/MixinUsage
include SearchAnalyzer
# rubocop:enable Style/MixinUsage

module SearchableGraphImage
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include SearchableCallbacks

    index_name [Rails.application.engine_name, Rails.env, "graph_image"].join("_")

    ### Custom settings and mappings
    settings(
      index: { number_of_shards: 1, number_of_replicas: 0 },
      analysis: SearchAnalyzer.analyzers
    ) do
      mappings do
        indexes :title, type: :string, analyzer: :filename_edge_autocomplete_index,
                        search_analyzer: :filename_autocomplete_search,
                        fields: { raw: { type: :string, analyzer: :filename_analyzer } }
        indexes :customer_id, type: :integer
        indexes :image_category_id, type: :integer
        indexes :deactivated, type: :boolean
      end
    end

    ### custom serialization
    def as_indexed_json(_options = {})
      ## due to custom as_json in tag.rb
      {
        id: id,
        title: title,
        customer_id: owner.customer.id,
        image_category_id: image_category_id,
        deactivated: deactivated
      }
    end

    def self.import_to_es
      GraphImage.__elasticsearch__.create_index! force: true
      GraphImage.import
    end

    ### Search methods
    # TODO: Refactor `self.search` into smaller private methods
    # rubocop:disable Metrics/MethodLength
    def self.search(term, current_customer, _body = {}, options = { size: 10_000 })
      search_definition = {
        query: {
          bool: {
            filter: {
              bool: {
                must: [{ term: { customer_id: current_customer } }],
                must_not: [{ term: { deactivated: true } }]
              }
            },
            must: {
              dis_max: {
                tie_breaker: 0.7,
                boost: 1.2,
                queries: es_image_search_query(term)
              }
            }
          }
        }
      }

      search_definition.deep_merge!(options)
      __elasticsearch__.search(search_definition)
    end
    # rubocop:enable Metrics/MethodLength

    def self.search_from_category(term, current_customer, category = nil, _body = {}, options = { size: 10_000 })
      search_definition = {
        query: {
          bool: {
            filter: es_filter_for(current_customer, category),
            must: {
              dis_max: {
                tie_breaker: 0.7,
                boost: 1.2,
                queries: es_image_search_query(term)
              }
            }
          }
        }
      }

      search_definition.deep_merge!(options)
      __elasticsearch__.search(search_definition)
    end

    def self.es_filter_for(customer, category)
      if category.nil?
        # filter for unclassified images search
        {
          bool: {
            must: [{ term: { customer_id: customer } }, { missing: { field: "image_category_id" } }],
            must_not: [{ term: { deactivated: true } }]
          }
        }
      else
        {
          bool: {
            must: [{ term: { customer_id: customer } }, { term: { image_category_id: category } }],
            must_not: [{ term: { deactivated: true } }]
          }
        }
      end
    end

    def self.es_image_search_query(term)
      {
        multi_match: {
          query: term,
          fields: ["title", "title.raw"],
          type: :most_fields
        }
      }
    end
  end
end
