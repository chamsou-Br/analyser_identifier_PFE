# frozen_string_literal: true

require "elasticsearch/model"

# TODO: Move `include` into module
# rubocop:disable Style/MixinUsage
include SearchAnalyzer
# rubocop:enable Style/MixinUsage

module SearchablePackage
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include SearchableCallbacks

    index_name [Rails.application.engine_name, Rails.env, "package"].join("_")

    ### Custom settings and mappings
    settings(
      index: { number_of_shards: 1, number_of_replicas: 0 },
      analysis: SearchAnalyzer.analyzers
    ) do
      mappings do
        indexes :name, type: :string, analyzer: :autocomplete_index, search_analyzer: :autocomplete_search,
                       fields: { raw: { type: :string, analyzer: :custom_standard } }
        indexes :description, type: :string, analyzer: :paragraph_analyzer
        indexes :categories do
          indexes :humanize_name, type: :string, analyzer: :custom_standard
        end
      end
    end

    ### custom serialization
    def as_indexed_json(_options = {})
      ## due to custom as_json in tag.rb
      as_json(only: %i[name description private deactivated customer_id
                       author_id state updated_at published_at],
              include: { categories: { only: [:id], methods: [:humanize_name] } }).merge!(
                customer_connections: package_connections.pluck(:customer_id),
                customer_nickname: customer.nickname,
                author_full_name: author.name.full_inv,
                customer_imported: imported_package_customers.pluck(:id).uniq
              )
    end

    def self.import_to_es
      Package.__elasticsearch__.create_index! force: true
      Package.import
    end

    ### Search method
    # TODO: define filter for the search
    # rubocop:disable Metrics/MethodLength
    def self.search(term, _current_user, filter = {}, options = {})
      search_definition = {
        query: {
          bool: {
            must: {
              dis_max: {
                tie_breaker: 0.7,
                boost: 1.2,
                queries: [
                  {
                    multi_match: {
                      query: term,
                      fields: ["name", "name.raw"],
                      type: :most_fields,
                      fuzziness: :auto,
                      boost: 10
                    }
                  },
                  {
                    match: {
                      description: {
                        query: term,
                        boost: 5
                      }
                    }
                  }
                ]
              }
            }
          }
        }
      }

      search_definition.merge!(options)
      search_definition[:query][:bool][:filter] = filter unless filter.blank?
      __elasticsearch__.search(search_definition)
    end
    # rubocop:enable Metrics/MethodLength
  end
end
