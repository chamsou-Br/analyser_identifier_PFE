# frozen_string_literal: true

require "elasticsearch/model"

module SearchableAudit
  extend ActiveSupport::Concern
  include SearchableRecord

  included do
    ### Custom settings and mappings
    settings(
      index: { number_of_shards: 1, number_of_replicas: 0 },
      analysis: SearchAnalyzerV2::ANALYZERS
    ) do
      mapping do
        # Main fields
        indexes :title, type: :string, analyzer: :text_analyzer,
                        fields: { autocomplete: { type: :string,
                                                  analyzer: :autocomplete_index_analyzer,
                                                  search_analyzer: :autocomplete_search_analyzer } }
        indexes :reference, type: :string, analyzer: :keyword_analyzer
        indexes :internal_reference, type: :string, analyzer: :internal_reference_analyzer
        indexes :object, type: :string, analyzer: :text_analyzer

        # Other fields
        indexes :synthesis, type: :string, analyzer: :text_analyzer
      end
    end

    ### custom serialization
    def as_indexed_json(_options = {})
      as_json(only: %i[title object synthesis reference internal_reference customer_id
                       created_at updated_at completed_at estimated_closed_at])
    end

    ##
    # Default search queries for searching audits with the specified term.
    #
    # @param [String] term
    # @return [Hash] ElasticSearch query
    #
    def self.default_search_query(term)
      {
        bool: {
          should: [
            multi_match(term, boost: 100, fields: %w[reference internal_reference]),
            multi_match(term, boost: 10,  fields: %w[title]),
            multi_match(term, boost: 1,   fields: %w[title object], fuzziness: :auto)
          ]
        }
      }
    end
  end
end
