# frozen_string_literal: true

# for i18n support in workers
require "sidekiq/middleware/i18n"

REDIS_CONFIG = {
  url: "redis://#{ENV.fetch('REDIS_URL', 'localhost:6379')}",
  namespace: "pyx4_#{Rails.env}"
}.freeze

Sidekiq.configure_server do |config|
  config.redis = REDIS_CONFIG
end

Sidekiq.configure_client do |config|
  config.redis = REDIS_CONFIG
end

Sidekiq.logger.level = Logger::WARN if Rails.env.test?

# Perform Sidekiq jobs immediately in development,
# so you don't have to run a separate process.
# You'll also benefit from code reloading.
# if Rails.env.development?
#   require "sidekiq/testing"
#   Sidekiq::Testing.inline!
# end
