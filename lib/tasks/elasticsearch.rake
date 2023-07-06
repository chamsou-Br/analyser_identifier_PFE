# frozen_string_literal: true

require "elasticsearch/rails/tasks/import"

namespace :es do
  desc "Force schema import to ElasticSearch"
  task import: :environment do
    ElasticsearchImporter.import
  end
end
