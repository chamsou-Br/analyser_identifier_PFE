# frozen_string_literal: true

require "elasticsearch/model"

module SearchableAction
  extend ActiveSupport::Concern
  include SearchableRecord

  INDEXED_JSON_FIELDS = %i[title description reference internal_reference customer_id
                           created_at updated_at real_closed_at estimated_closed_at].freeze

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
        indexes :description, type: :string, analyzer: :text_analyzer

        # Other fields
        indexes :provenances, type: :string, analyzer: :text_analyzer
        indexes :localisations, type: :string, analyzer: :text_analyzer
      end
    end

    ### custom serialization
    def as_indexed_json(_options = {})
      as_json(only: INDEXED_JSON_FIELDS).merge!(
        provenances: by_event_description,
        localisations: localisations.pluck(:label)
      )
    end

    # This method extracts the description of the events related to the action
    # to allow for searching based on that value.
    #
    # TODO: needs testing
    # TODO: this will become a more general method, if needed, when other
    # entities associated with the current, are searched based on a fieldable.
    #
    def by_event_description
      events.map { |e| e.field_value_value("description") }
    end

    ##
    # Default search queries for searching actions with the specified term.
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
