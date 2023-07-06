# frozen_string_literal: true

module I18n
  class MissingKeyLogger < ExceptionHandler
    def call(exception, *args)
      self.class.log_the(exception.message) if exception.is_a?(ArgumentError)
      super
    end

    def self.log_the(message)
      NotifyMissingI18nKeyWorker.perform_async(message)
    end
  end
end

I18n.exception_handler = I18n::MissingKeyLogger.new
