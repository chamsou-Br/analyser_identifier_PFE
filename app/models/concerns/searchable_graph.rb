# frozen_string_literal: true

require "elasticsearch/model"

# TODO: Refactor `SearchableGraph` into smaller module with shared components
module SearchableGraph
  extend ActiveSupport::Concern
  include SearchableRecord

  included do
    ### Custom settings and mappings
    settings(
      index: { number_of_shards: 1, number_of_replicas: 0 },
      analysis: SearchAnalyzer.analyzers
    ) do
      mappings do
        indexes :title, type: :string, analyzer: :edge_autocomplete_index, search_analyzer: :autocomplete_search,
                        fields: { raw: { type: :string, analyzer: :custom_standard } }
        indexes :type, type: :string, analyzer: :custom_standard
        indexes :state, type: :string, analyzer: :custom_standard
        indexes :reference, type: :string, analyzer: :edge_autocomplete_index, search_analyzer: :autocomplete_search,
                            fields: { raw: { type: :string, analyzer: :custom_standard } }
        indexes :purpose, type: :string, analyzer: :paragraph_analyzer
        indexes :domain, type: :string, analyzer: :custom_standard
        indexes :tags, type: :string, analyzer: :custom_standard
        indexes :news, type: :string, analyzer: :paragraph_analyzer
        indexes :directory_id, index: :not_analyzed
        indexes :tag_ids, index: :not_analyzed
      end
    end

    ### custom serialization
    def as_indexed_json(_options = {})
      ## due to custom as_json in tag.rb
      as_json(only: %i[id title type state reference purpose level domain
                       customer_id author_id groupgraph_id confidential version
                       news created_at directory_id]).merge!(tags: tags.reload.pluck(:label),
                                                             tag_ids: tags.reload.pluck(:id))
    end

    # TODO: Refactor `self.import_to_es` into smaller private method
    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def self.import_to_es
      ### creating elasticsearch index
      # TODO: Remove `rescue nil` in favor of specific rescue in non-modifier
      # form
      # rubocop:disable Style/RescueModifier
      Graph.__elasticsearch__.client.indices.delete index: Graph.index_name rescue nil
      # rubocop:enable Style/RescueModifier
      Graph.__elasticsearch__.client.indices.create \
        index: Graph.index_name,
        body: {
          settings: Graph.settings.to_hash,
          mappings: Graph.mapping
        }

      ### Importing data
      Graph.import
      [GraphsViewer, GraphsApprover, GraphsVerifier, GraphPublisher].each do |element|
        element.import transform: lambda { |object|
                                    {
                                      index: {
                                        _id: object.id,
                                        _parent: object.graph_id,
                                        data: object.__elasticsearch__.as_indexed_json
                                      }
                                    }
                                  }
        ContributablesContributor.import transform: lambda { |object|
          {
            index: {
              _id: object.id,
              _parent: object.contributable_id,
              data: object.__elasticsearch__.as_indexed_json
            }
          }
        }
      end
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

    ### generating graph mapping from all associated records of the graph model
    def self.mapping
      associated_hash = {}
      [GraphsViewer, GraphsApprover, GraphsVerifier, GraphPublisher, ContributablesContributor].each do |element|
        associated_hash.merge!(element.mappings.to_hash)
      end

      ### merging mappings to graph object
      Graph.mappings.to_hash.merge!(associated_hash)
    end

    ### Search method
    def self.search(term, user, _customer, filter = {}, options = {})
      search_definition = {
        query: {
          bool: {
            filter: policy_es_filter(user),
            must: [{
              dis_max: {
                tie_breaker: 0.7,
                boost: 1.2,
                queries: search_queries(term)
              }
            }]
          }
        }
      }

      search_definition.deep_merge!(options)
      search_definition[:query][:bool][:filter][:bool].deep_merge!(filter) do |_key, old_val, new_val|
        old_val + new_val
      end

      __elasticsearch__.search(search_definition)
    end

    # TODO: Refactor `self.search_queries` into smaller private method
    # rubocop:disable Metrics/MethodLength
    def self.search_queries(term)
      [
        {
          multi_match: {
            query: term,
            fields: ["title", "title.raw"],
            type: :most_fields,
            boost: 10
          }
        },
        {
          multi_match: {
            query: term,
            fields: ["reference", "reference.raw"],
            type: :most_fields,
            boost: 5
          }
        },
        {
          match: {
            type: {
              query: term,
              boost: 1
            }
          }
        },
        {
          match: {
            purpose: {
              query: term,
              fuzziness: :auto,
              boost: 1
            }
          }
        },
        {
          match: {
            domain: {
              query: term,
              fuzziness: :auto,
              boost: 1
            }
          }
        },
        {
          match: {
            news: {
              query: term,
              fuzziness: :auto,
              boost: 1
            }
          }
        },
        {
          match: {
            tags: {
              query: term,
              boost: 1
            }
          }
        }
      ]
    end
    # rubocop:enable Metrics/MethodLength

    def self.search_list_queries(term)
      [
        {
          multi_match: {
            query: term,
            fields: ["title", "title.raw"],
            type: :most_fields,
            boost: 10
          }
        },
        {
          multi_match: {
            query: term,
            fields: ["reference", "reference.raw"],
            type: :most_fields,
            boost: 5
          }
        }
      ]
    end

    def self.search_list(term, user, _customer)
      __elasticsearch__.search(size: 10_000,
                               query: {
                                 bool: {
                                   filter: [policy_es_filter(user)],
                                   must: [
                                     dis_max: {
                                       tie_breaker: 0.7,
                                       boost: 1.2,
                                       queries: search_list_queries(term)
                                     }
                                   ]
                                 }
                               }).records
    end

    def self.search_all(term, user, customer)
      search(term, user, customer, {}, size: 10_000).records
    end

    # search for applicable graphs
    # TODO: Refactor `self.search_applicable` into smaller private methods
    # rubocop:disable Metrics/MethodLength
    def self.search_applicable(term, user, filter = {}, options = {})
      search_definition = {
        query: {
          bool: {
            filter: {
              bool: {
                must: [
                  { term: { customer_id: user.customer_id } },
                  { term: { state: "applicable" } }
                ]
              }
            }
          }
        }
      }
      unless term.blank?
        search_definition[:query][:bool][:must] = [{
          dis_max: {
            tie_breaker: 0.7,
            boost: 1.2,
            queries: search_list_queries(term)
          }
        }]
      end

      search_definition.deep_merge!(options)
      search_definition[:query][:bool][:filter][:bool].deep_merge!(filter) do |_key, old_val, new_val|
        old_val + new_val
      end

      __elasticsearch__.search(search_definition).records
    end
    # rubocop:enable Metrics/MethodLength

    # search for lastest version
    # TODO: Refactor `self.search_latest` into smaller private methods
    # rubocop:disable Metrics/MethodLength
    def self.search_latest(term, user, filter = {}, options = {})
      search_definition = {
        query: {
          bool: {
            filter: {
              bool: {
                must_not: [
                  { terms: { state: %w[deactivated archived] } }
                ],
                must: [
                  { term: { customer_id: user.customer_id } },
                  { ids: { values: latest_aggregation(user) } }
                ]
              }
            }
          }
        }
      }

      unless term.blank?
        search_definition[:query][:bool][:must] = [{
          dis_max: {
            tie_breaker: 0.7,
            boost: 1.2,
            queries: search_list_queries(term)
          }
        }]
      end

      search_definition.deep_merge!(options)
      search_definition[:query][:bool][:filter][:bool].deep_merge!(filter) do |_key, old_val, new_val|
        old_val + new_val
      end

      __elasticsearch__.search(search_definition).records
    end
    # rubocop:enable Metrics/MethodLength

    # return graph_ids which is the latest of its groupgraph
    # TODO: Refactor `self.latest_aggregation` into smaller private methods
    # rubocop:disable Metrics/MethodLength
    def self.latest_aggregation(user)
      agg_definition = {
        size: 0,
        query: {
          bool: {
            filter: {
              bool: {
                must_not: [
                  { terms: { state: %w[deactivated archived] } }
                ],
                must: [
                  { term: { customer_id: user.customer_id } }
                ]
              }
            }
          }
        },
        aggregations: {
          group_by_groupgraph: {
            terms: {
              field: "groupgraph_id",
              size: 1_000_000
            },
            aggs: {
              latest: {
                max: {
                  field: "id"
                }
              }
            }
          }
        }
      }

      __elasticsearch__.search(agg_definition).results.response.aggregations
                       .group_by_groupgraph.buckets
                       .map { |bucket| bucket.latest.value.to_i }
    end
    # rubocop:enable Metrics/MethodLength

    # TODO: Refactor `self.applicable_filter` into smaller private methods
    # rubocop:disable Metrics/MethodLength
    def self.applicable_filter(user, options = {})
      filter = {
        bool: {
          should: [
            {
              bool: {
                must: [{ term: { state: "applicable" } }, { term: { confidential: false } }]
              }
            },
            {
              bool: {
                must: [
                  { term: { confidential: true } }, { term: { state: "applicable" } },
                  {
                    has_child: {
                      type: "graphs_viewer",
                      query: {
                        bool: {
                          must: [{
                            bool: {
                              should: [
                                { bool: { must: [{ term: { viewer_type: "group" } },
                                                 { terms: { viewer_id: user.groups.pluck(:id) } }] } },
                                { bool: { must: [{ term: { viewer_type: "user" } },
                                                 { term: { viewer_id: { value: user.id } } }] } },
                                { bool: { must: [{ term: { viewer_type: "role" } },
                                                 { terms: { viewer_id: user.roles.pluck(:id) } }] } }
                              ]
                            }
                          }]
                        }
                      }
                    }
                  }
                ]
              }
            }
          ]
        }
      }
      filter.deep_merge(options) { |_key, this_val, new_val| this_val + new_val }
    end
    # rubocop:enable Metrics/MethodLength

    # TODO: Refactor `self.policy_es_filter` into smaller private methods
    # rubocop:disable Metrics/MethodLength
    def self.policy_es_filter(user, options = {})
      if user.process_admin?
        filter = {
          bool: {
            must_not: [{ term: { state: "archived" } }],
            must: [{ term: { customer_id: user.customer_id } }]
          }
        }
      else
        filter = {
          bool: {
            must_not: [{ term: { state: "archived" } }],
            must: [{ term: { customer_id: user.customer_id } }],
            should: [
              {
                term: {
                  author_id: user.id
                }
              },
              {
                bool: {
                  must_not: [{ term: { state: "new" } }],
                  should: [
                    {
                      has_child: {
                        type: "graphs_approver",
                        query: {
                          term: {
                            approver_id: {
                              value: user.id
                            }
                          }
                        }
                      }
                    },
                    {
                      has_child: {
                        type: "graphs_verifier",
                        query: {
                          term: {
                            verifier_id: {
                              value: user.id
                            }
                          }
                        }
                      }
                    },
                    {
                      has_child: {
                        type: "graph_publisher",
                        query: {
                          term: {
                            publisher_id: {
                              value: user.id
                            }
                          }
                        }
                      }
                    }
                  ]
                }
              },
              {
                bool: {
                  must: [
                    {
                      term: {
                        state: "new"
                      }
                    },
                    {
                      has_child: {
                        type: "contributables_contributor",
                        query: {
                          term: {
                            contributor_id: {
                              value: user.id
                            }
                          }
                        }
                      }
                    }
                  ]
                }
              }
            ]
          }
        }
        filter = filter.deep_merge(applicable_filter(user)) { |_key, this_val, other_val| this_val + other_val }
      end
      filter.deep_merge(options) { |_key, this_val, new_val| this_val + new_val }
    end
    # rubocop:enable Metrics/MethodLength

    ##
    # Default search query for searching graphs with the specified term.
    #
    # @param [String] term
    # @return [Hash] ElasticSearch query
    #
    def self.default_search_query(term)
      {
        bool: {
          should: search_queries(term)
        }
      }
    end
  end
end
