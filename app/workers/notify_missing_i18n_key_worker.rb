# frozen_string_literal: true

class NotifyMissingI18nKeyWorker
  include Sidekiq::Worker

  sidekiq_options queue: :i18n

  def perform(message)
    # Get user passed into docker container or fallback to linux user for
    # non-docker cases
    user = ENV.fetch("RAILS_USER", ENV["USER"])

    # Get hostname passed into docker container or fallback to linux
    # `hostname` for non-docker cases
    hostname = ENV.fetch("RAILS_HOSTNAME", `hostname`.chomp)

    # formatting
    message = [
      "```#{message}```",
      "This was discovered by **#{user}@#{hostname}**"
    ].join("\n")

    # getting notifier object ready
    notifier = Slack::Notifier.new "https://mattermost.qualiproto.fr/hooks/nsnhnha977yajck3oubiwzhifh" do
      defaults channel: "missing-translations"
    end

    # logging
    Rails.logger.error message
    notifier.ping message
  end
end
