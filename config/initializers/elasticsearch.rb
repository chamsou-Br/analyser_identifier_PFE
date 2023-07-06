# frozen_string_literal: true

# Connect to specific ElasticSearch cluster
ELASTICSEARCH_URL = "http://#{ENV.fetch('ELASTICSEARCH_URL', 'elasticsearch:9200')}"

Elasticsearch::Model.client = Elasticsearch::Client.new host: ELASTICSEARCH_URL

# Print Curl-formatted traces in development into a file
#
if Rails.env.development? || ENV.fetch("PYX4_ELASTICSEACH_DEBUG", false)
  tracer = Logger.new("log/elasticsearch.log")
  tracer.level = Logger::DEBUG
  Elasticsearch::Model.client.transport.tracer = tracer
end
