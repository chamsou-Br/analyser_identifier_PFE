# frozen_string_literal: true

module SearchableRisk
  extend ActiveSupport::Concern
  include SearchableRecord

  included do
    #
    # Configure ElasticSearch indexes for the Risk model.
    #
    # @see https://github.com/elastic/elasticsearch-rails/tree/master/elasticsearch-model#index-configuration
    #
    settings(
      index: { number_of_shards: 1, number_of_replicas: 0 },
      analysis: SearchAnalyzerV2::ANALYZERS
    ) do
      mapping do
        indexes :title,
                type: :string,
                analyzer: :text_analyzer,
                fields: {
                  autocomplete: {
                    type: :string,
                    analyzer: :autocomplete_index_analyzer,
                    search_analyzer: :autocomplete_search_analyzer
                  }
                }

        indexes :reference,
                type: :string,
                analyzer: :keyword_analyzer

        indexes :internal_reference,
                type: :string,
                analyzer: :internal_reference_analyzer

        indexes :description,
                type: :string,
                analyzer: :text_analyzer
      end
    end

    #
    # Defines how the Risk will be serialized in ElasticSearch.
    #
    # @see https://github.com/elastic/elasticsearch-rails/tree/master/elasticsearch-model#model-serialization
    #
    def as_indexed_json(_options = {})
      as_json(only: :internal_reference)
        .merge!(title: field_value_value("title"),
                reference: field_value_value("reference"),
                description: field_value_value("description"))
    end

    #
    # Default search query for searching risks with the specified term.
    #
    # @param [String] term
    # @return [Hash] ElasticSearch query
    #
    def self.default_search_query(term)
      {
        bool: {
          should: [
            multi_match(term, boost: 100,
                              fields: %w[reference internal_reference]),
            multi_match(term, boost: 10,
                              fields: %w[title]),
            multi_match(term, boost: 1,
                              fields: %w[title description], fuzziness: :auto)
          ]
        }
      }
    end
  end
end
