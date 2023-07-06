# frozen_string_literal: true

require "elasticsearch/model"

module SearchableGraphsApprover
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include SearchableCallbacks

    index_name [Rails.application.engine_name, Rails.env, "graph"].join("_")

    ### Custom settings and mappings
    settings(
      index: { number_of_shards: 1, number_of_replicas: 0 }
    ) do
      mapping _parent: { type: "graph" } do
      end
    end

    ### custom serialization
    def as_indexed_json(_options = {})
      ## due to custom as_json in tag.rb
      as_json(only: %i[graph_id approver_id])
    end
    ### Search method
  end
end
