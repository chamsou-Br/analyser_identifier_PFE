# frozen_string_literal: true

module SearchableUser
  extend ActiveSupport::Concern
  include SearchableRecord

  included do
    ### Custom settings and mapping for indexation
    settings(
      index: { number_of_shards: 1, number_of_replicas: 0 },
      analysis: SearchAnalyzer.analyzers
    ) do
      mappings do
        indexes :full_name, type: :string, analyzer: :autocomplete_index,
                            search_analyzer: :autocomplete_search,
                            fields: { raw: { type: :string, analyzer: :custom_standard } }
        indexes :function, type: :string, analyzer: :edge_autocomplete_index,
                           search_analyzer: :autocomplete_search,
                           fields: { raw: { type: :string, analyzer: :custom_standard } }
        indexes :firstname, type: :string, copy_to: :full_name
        indexes :lastname, type: :string, copy_to: :full_name
        indexes :email, type: :string, analyzer: :email_prefix_autocomplete_index,
                        search_analyzer: :email_prefix_autocomplete_search,
                        fields: { raw: { type: :string, analyzer: :email } }
        indexes :profile_type, type: :string, index: :not_analyzed
        indexes :deactivated, type: :boolean, index: :not_analyzed
      end
    end

    ### custom serialization
    def as_indexed_json(_options = {})
      as_json(only: %i[id firstname lastname supervisor_id profile_type email
                       customer_id deactivated function])
    end

    ### Search methods
    # TODO: Refactor `self.search` into smaller private methods
    # rubocop:disable Metrics/MethodLength
    def self.search(term, user, filter = {}, options = {})
      query_filter = { bool: { must: [{ term: { customer_id: user.customer_id } }] } }

      # Refactor to direct write, e.g.:
      # query_filter[:bool][:must_not] = [{ term: { deactivated: true } }]
      # rubocop:disable Performance/RedundantMerge
      query_filter[:bool].merge!(must_not: [{ term: { deactivated: true } }]) unless user.process_admin?
      # rubocop:enable Performance/RedundantMerge

      search_definition = {
        query: {
          bool: {
            filter: query_filter,
            must: {
              dis_max: {
                tie_breaker: 0.7,
                boost: 1.2,
                queries: [
                  {
                    multi_match: {
                      query: term,
                      fields: ["full_name", "full_name.raw"],
                      boost: 10,
                      type: :most_fields
                    }
                  },
                  {
                    multi_match: {
                      query: term,
                      fields: ["email", "email.raw"],
                      boost: 5,
                      type: :most_fields
                    }
                  },
                  {
                    multi_match: {
                      query: term,
                      fields: ["function", "function.raw"],
                      boost: 2,
                      type: :most_fields,
                      fuzziness: :auto
                    }
                  }
                ]
              }
            }
          }
        }
      }

      search_definition.merge!(options)
      search_definition[:query][:bool][:filter][:bool].deep_merge!(filter) do |_key, old_val, new_val|
        old_val + new_val
      end

      __elasticsearch__.search(search_definition)
    end
    # rubocop:enable Metrics/MethodLength

    def self.search_list(term, user, filter = {}, _options = {})
      search(term, user, filter, size: 10_000).records
    end

    def self.search_all(term, user)
      search(term, user, {}, size: 10_000).records
    end
    ### Search methods

    ##
    # Default search query for searching users with the specified term.
    #
    # @param [String] term
    # @return [Hash] ElasticSearch query
    #
    def self.default_search_query(term)
      {
        bool: {
          should: [
            multi_match(term, boost: 10, fields: %w[full_name full_name.raw]),
            multi_match(term, boost: 5,  fields: %w[email email.raw]),
            multi_match(term, boost: 2,  fields: %w[function function.raw], fuzziness: :auto)
          ]
        }
      }
    end
  end
end
