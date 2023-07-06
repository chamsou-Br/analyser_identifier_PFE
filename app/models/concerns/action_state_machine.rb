# frozen_string_literal: true

module ActionStateMachine
  extend ActiveSupport::Concern

  # The state in the act model is an enum as follows:
  # enum state: { in_creation: 0,  # AKA Planning
  #               planned: 5,
  #               in_progress: 1,
  #               pending_approval: 2,
  #               canceled: 3,
  #               closed: 4}

  included do
    # rubocop:disable Style/HashSyntax

    state_machine :state, initial: :planned do
      after_transition to: :in_progress do |act|
        act.update(real_started_at: Date.today)
      end

      after_transition to: :pending_approval do |act|
        act.update(completed_at: Date.today)
      end

      after_transition to: :closed do |act|
        act.update(real_closed_at: Date.today)
        act.events.each(&:auto_close) if act.efficient?

        # TODO: to be addressed by #2385
        # Same line found in app/graphql/types/action_type.rb
        # At the moment the only `plannable` is of type risk, so it is
        # safe for the time being. After the direct risks<-->acts associations
        # is deleted, it will be time to revisit here and make sure that the
        # plannable is a risk, with either another association or a test.
        #
        act.action_plans.map(&:plannable).each do |risk|
          next unless risk.actions_closed_efficient?

          # TODO: the risk should be closed, which is the normal flow.
          # Any other transition to under_analysis is a short cut, like
          # starting the process from scratch.
          # Perhaps a new transition is needed, called re_evaluate.
          # This distinction is already made in the notifications.
          #
          risk.back_to_analysis
          risk.notify_on_update_evaluation(risk.author)
        end
      end

      # author
      event :create_please do
        transition :in_creation => :planned,
                   if: ->(a) { a.required_desc_fields? }
      end

      # owner
      event :start_processing do
        transition :planned => :in_progress,
                   if: ->(a) { a.required_desc_fields? }
      end

      # owner
      event :ask_approval do
        transition :in_progress => :pending_approval,
                   if: ->(a) { a.progress_complete? && a.required_desc_fields? }
      end

      # Need to preceed method name by to_ to avoid clashes
      # validator
      event :close_action do
        transition :pending_approval => :closed,
                   if: ->(a) { a.required_eval_fields? }
      end

      # validator, owner
      event :cancel_action do
        transition %i[in_creation
                      planned
                      in_progress] => :canceled
      end
    end
    # rubocop:enable Style/HashSyntax
  end
end
