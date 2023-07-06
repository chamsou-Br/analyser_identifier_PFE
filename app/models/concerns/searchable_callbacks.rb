# frozen_string_literal: true

module SearchableCallbacks
  extend ActiveSupport::Concern
  included do
    after_commit on: %i[create update] do |entity|
      if entity.class.mappings.options[:_parent].blank?
        entity.__elasticsearch__.index_document
      else
        parent = if entity.is_a?(ContributablesContributor)
                   entity.contributable
                 else
                   entity.send entity.class.mapping.options[:_parent][:type]
                 end
        entity.__elasticsearch__.index_document(parent: parent.id) unless parent.nil?
      end

      if entity.is_a?(Tag)
        Tagging.where(tag_id: entity.id).each do |tagging|
          tagging.taggable.__elasticsearch__.index_document
        end
      end

      entity.class.__elasticsearch__.refresh_index! if Rails.env.test?
    rescue Elasticsearch::Transport::Transport::Errors::NotFound => e
      unavailable_index(e)
    rescue Faraday::ConnectionFailed => e
      unavailable_service(e)
    end

    after_commit on: [:destroy] do |entity|
      if entity.class.mappings.options[:_parent].blank?
        entity.__elasticsearch__.delete_document
      else
        parent = if entity.is_a?(ContributablesContributor)
                   entity.contributable
                 else
                   entity.send entity.class.mapping.options[:_parent][:type]
                 end
        entity.__elasticsearch__.delete_document(parent: parent.id) unless parent.nil?
      end

      entity.class.__elasticsearch__.refresh_index! if Rails.env.test?
    rescue Elasticsearch::Transport::Transport::Errors::NotFound => e
      unavailable_index(e)
    rescue Faraday::ConnectionFailed => e
      unavailable_service(e)
    end
  end

  def unavailable_service(exception)
    ExceptionNotifyService.notify(exception, "unavailable service")
  end

  def unavailable_index(exception)
    ExceptionNotifyService.notify(exception, "unavailable index")
  end
end
