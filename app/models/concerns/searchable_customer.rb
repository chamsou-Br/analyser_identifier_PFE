# frozen_string_literal: true

require "elasticsearch/model"

# TODO: Move `include` into module
# rubocop:disable Style/MixinUsage
include SearchAnalyzer
# rubocop:enable Style/MixinUsage

module SearchableCustomer
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include SearchableCallbacks

    ## to ensure that future import will be on the same index
    index_name [Rails.application.engine_name, Rails.env, "customer"].join("_")
    ###

    ### Custom settings and mapping for indexation
    settings(
      index: { number_of_shards: 1, number_of_replicas: 0 },
      analysis: SearchAnalyzer.analyzers
    ) do
      mappings do
        indexes :url, type: :string, analyzer: :pyx4_url_autocomplete_analyzer, search_analyzer: :autocomplete_search,
                      fields: { raw: { type: :string, analyzer: :pyx4_url_analyzer } }
      end
    end

    ### custom serialization
    def as_indexed_json(_options = {})
      # as_json(only: [ :id, :url, :contact_name, :contact_email, :contact_phone ])
      as_json(only: %i[id url])
    end

    ### Indexing and importing all the data to elasticsearch
    def self.import_to_es
      Customer.__elasticsearch__.create_index! force: true
      Customer.import
    end

    ### Search methods
    def self.search(term, _body = {}, options = {})
      search_definition = {
        query: {
          multi_match: {
            query: term,
            fields: ["url", "url.raw"],
            type: :most_fields
          }
        }
      }

      search_definition.merge!(options)
      # search_definition[:query].merge!(body)

      __elasticsearch__.search(search_definition)
    end

    def self.search_list(term)
      search_all(term)
    end

    def self.search_all(term)
      search(term, {}, size: 10_000).records
    end
    ### Search methods
  end
end
