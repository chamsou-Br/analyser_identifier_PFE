# frozen_string_literal: true

require "elasticsearch/model"

##
# An abstraction of common functions used for a record searchable with ElasticSearch.
#
# Models that include this concern will have to add the `default_search_query`
# method that will be used for generic search methods.
#
# @example
#
#   ##
#   # @param [String] term
#   # @return [Hash] ElasticSearch query
#   #
#   def self.default_search_query(term)
#     { match: { title: term } }
#   end
#
module SearchableRecord
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include SearchableCallbacks

    # example : "qualipso_application_production_graph"
    index_name [Rails.application.engine_name, Rails.env, name.underscore].join("_")

    ##
    # Create index and import all data to ElasticSearch
    #
    def self.import_to_es
      logger.info "ElasticSearch: importing all #{name} records..."

      __elasticsearch__.delete_index! if __elasticsearch__.index_exists?
      __elasticsearch__.create_index!
      import
    end

    ##
    # Search the ElasticSearch query within the specified ids.
    #
    # @param [Array<Integer>] ids
    #        Ids of entities for which the search will be executed.
    # @param [Hash] query
    #        ElasticSearch query such as `{ match: { title: "My event" } }`
    #
    # @return [Elasticsearch::Model::Response::Response]
    #
    def self.search_query_within_ids(ids:, query:)
      __elasticsearch__.search(
        query: {
          bool: {
            must: query,
            filter: [{ terms: { _id: ids } }]
          }
        }
      )
    end

    ##
    # Search the term in entities with the id in specified ids.
    # It uses the `default_search_query` defined in the included model.
    #
    # @param [String] term
    # @param [Array<Integer>] ids
    #        Ids of entities for which the search will be executed.
    #
    def self.search_within(ids:, term:)
      search_query_within_ids(query: default_search_query(term), ids: ids)
    end

    ##
    # Search the term in entities the user has access to.
    #
    # @param [String] term
    # @param [User] user The user searching entities
    #
    def self.search_with_access(term:, user:)
      search_within(ids: Pundit.policy_scope!(user, self).pluck(:id),
                    term: term)
    end

    ##
    # Return a common multi-match query. This is just used for less verbosity
    # @see https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-multi-match-query.html
    #
    def self.multi_match(term, **options)
      { multi_match: { query: term, type: :most_fields, **options } }
    end
  end
end
