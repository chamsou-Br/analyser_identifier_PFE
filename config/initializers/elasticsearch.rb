# frozen_string_literal: true

# Connect to specific ElasticSearch cluster
ELASTICSEARCH_URL = "http://#{ENV.fetch('ELASTICSEARCH_URL', 'elasticsearch:9200')}"


config = {
  host: "localhost",
  port: 9200,                            
  scheme: "http",                              
  retry_on_failure: true,
  transport_options: {
    request: { timeout: 10 }
  }
}

Elasticsearch::Model.client = Elasticsearch::Client.new(config)

# Print Curl-formatted traces in development into a file
#
if Rails.env.development? || ENV.fetch("PYX4_ELASTICSEACH_DEBUG", false)
  tracer = Logger.new("log/elasticsearch.log")
  tracer.level = Logger::DEBUG
  Elasticsearch::Model.client.transport.tracer = tracer
end

