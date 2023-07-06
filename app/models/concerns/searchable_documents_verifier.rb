# frozen_string_literal: true

require "elasticsearch/model"

module SearchableDocumentsVerifier
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include SearchableCallbacks

    index_name [Rails.application.engine_name, Rails.env, "document"].join("_")

    ### Custom settings and mappings
    settings(
      index: { number_of_shards: 1, number_of_replicas: 0 }
    ) do
      mappings _parent: { type: "document" } do
      end
    end

    ### custom serialization
    def as_indexed_json(_options = {})
      ## due to custom as_json in tag.rb
      as_json(only: %i[document_id verifier])
    end

    ### Search method
  end
end
