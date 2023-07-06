# frozen_string_literal: true

require "elasticsearch/model"

module SearchableEvent
  extend ActiveSupport::Concern
  include SearchableRecord

  INDEXED_ATTRS = %i[internal_reference reference
                     cost consequence analysis author_id owner_id state
                     customer_id created_at updated_at].freeze

  included do
    ### Custom settings and mappings
    settings(
      index: { number_of_shards: 1, number_of_replicas: 0 },
      analysis: SearchAnalyzerV2::ANALYZERS
    ) do
      mapping do
        # Main fields
        indexes :description, type: :string, analyzer: :text_analyzer
        indexes :internal_reference,
                type: :string, analyzer: :internal_reference_analyzer
        indexes :reference,
                type: :string, analyzer: :keyword_analyzer
        indexes :title,
                type: :string, analyzer: :text_analyzer,
                fields: { autocomplete: {
                  type: :string,
                  analyzer: :autocomplete_index_analyzer,
                  search_analyzer: :autocomplete_search_analyzer
                } }

        # Other fields
        indexes :analysis, type: :string, analyzer: :text_analyzer
        indexes :consequence, type: :string, analyzer: :text_analyzer
        indexes :cost, type: :string, analyzer: :text_analyzer
        indexes :intervention, type: :string, analyzer: :text_analyzer
        indexes :localisations, type: :string, analyzer: :text_analyzer
        indexes :provenances, type: :string, analyzer: :text_analyzer
      end
    end

    ### custom serialization
    def as_indexed_json(_options = {})
      as_json(only: INDEXED_ATTRS)
        .merge!(description: field_value_value("description"),
                domains: domains.pluck(:id),
                intervention: field_value_value("intervention"),
                localisations: localisations.pluck(:label),
                provenances: audits.pluck(:title),
                title: field_value_value("title"),
                type: event_type_id)
    end

    ##
    # Default search queries for searching events with the specified term.
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
            multi_match(term, boost: 1,   fields: %w[title description], fuzziness: :auto)
          ]
        }
      }
    end
  end
end
