# frozen_string_literal: true

require "elasticsearch/model"

# TODO: Move `include` into module
# rubocop:disable Style/MixinUsage
include SearchAnalyzer
# rubocop:enable Style/MixinUsage

# TODO: Refactor `SearchableDocument` into smaller inherited classes/methods
module SearchableDocument
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
        indexes :reference, type: :string, analyzer: :edge_autocomplete_index, search_analyzer: :autocomplete_search,
                            fields: { raw: { type: :string, analyzer: :custom_standard } }
        indexes :purpose, type: :string, analyzer: :paragraph_analyzer
        indexes :state, type: :string, analyzer: :custom_standard
        indexes :news, type: :string, analyzer: :paragraph_analyzer
        indexes :domain, type: :string, analyzer: :paragraph_analyzer
        indexes :url, type: :string, analyzer: :url_analyzer
        indexes :tags, type: :string, analyzer: :custom_standard
        indexes :directory_id, index: :not_analyzed
      end
    end

    ### custom serialization
    def as_indexed_json(_options = {})
      as_json(
        only: %i[id title reference purpose domain state news customer_id
                 confidential author_id groupdocument_id url directory_id]
      ).merge!(tags: tags.reload.pluck(:label))
    end

    def self.import_to_es
      ### creating elasticsearch index
      # TODO: Prefer rescuing specific Error in non-modifier form
      # rubocop:disable Style/RescueModifier
      Document.__elasticsearch__.client.indices.delete index: Document.index_name rescue nil
      # rubocop:enable Style/RescueModifier
      Document.__elasticsearch__.client.indices.create \
        index: Document.index_name,
        body: {
          settings: Document.settings.to_hash,
          mappings: Document.mapping
        }

      ### Importing data
      Document.import
      [DocumentsViewer, DocumentsApprover, DocumentsVerifier, DocumentPublisher].each do |element|
        element.import transform: lambda { |object|
                                    {
                                      index: {
                                        _id: object.id,
                                        _parent: object.document_id,
                                        data: object.__elasticsearch__.as_indexed_json
                                      }
                                    }
                                  }
      end
    end

    ### generating graph mapping from all associated records of the graph model
    def self.mapping
      associated_hash = {}
      [DocumentsViewer, DocumentsApprover, DocumentsVerifier, DocumentPublisher].each do |element|
        associated_hash.merge!(element.mappings.to_hash)
      end

      ### merging mappings to graph object
      Document.mappings.to_hash.merge!(associated_hash)
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

    # TODO: Refactor `self.search_queries` into smaller private methods
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
            url: {
              query: term,
              fuzziness: :auto,
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
            news: {
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
            tags: {
              query: term,
              boost: 1
            }
          }
        }
      ]
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
                must: [{ term: { state: "applicable" } }, { term: { confidential: true } }],
                filter: [
                  {
                    has_child: {
                      type: "documents_viewer",
                      query: {
                        bool: {
                          must: [{
                            bool: {
                              should: [
                                { bool: { must: [{ term: { viewer_type: "group" } },
                                                 { terms: { viewer_id: user.groups.pluck(:id) } }] } },
                                { bool: { must: [{ term: { viewer_type: "role" } },
                                                 { terms: { viewer_id: user.roles.pluck(:id) } }] } },
                                { bool: { must: [{ term: { viewer_type: "user" } },
                                                 { term: { viewer_id: { value: user.id } } }] } }
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

    def self.search_list(term, user, _customer)
      __elasticsearch__.search(size: 10_000,
                               query: {
                                 bool: {
                                   filter: [policy_es_filter(user)],
                                   must: [{
                                     multi_match: {
                                       query: term,
                                       fields: ["title", "title.raw^2", "reference", "reference.raw^2"],
                                       type: :best_fields,
                                       tie_breaker: 0.3
                                     }
                                   }]
                                 }
                               }).records
    end

    def self.search_all(term, user, customer)
      search(term, user, customer, {}, size: 10_000).records
    end

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
                        type: "documents_approver",
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
                        type: "documents_verifier",
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
                        type: "document_publisher",
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
    # Default search query for searching documents with the specified term.
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
