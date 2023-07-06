# frozen_string_literal: true

module EventStateMachine
  extend ActiveSupport::Concern

  # The state in the event model is an enum as follows:
  # enum state: { under_analysis: 0,
  #               pending_approval: 1,
  #               completed: 2,
  #               closed: 3,
  #               in_creation: 4,
  #               pending_closure: 5 }

  included do
    # rubocop:disable Style/HashSyntax
    # The author only creates the event and puts it into under_analysis state
    state_machine :state, initial: :under_analysis do
      ## AFTER TRANSITION HOOKS

      after_transition to: :closed do |event|
        event.update(closed_at: Date.today)
        event.audits.each(&:auto_close)
        event.audit_elements.map(&:audit).each(&:auto_close)
      end

      after_transition to: :under_analysis do |event|
        event.reset_cim_and_validator_response
        event.update(closed_at: nil)
      end

      after_transition to: :completed do |event|
        event.acts.each(&:create_please)
        event.closed! if event.actions_closed_efficient?
      end

      ## TRANSITIONS

      # "The only usage of this status is when it is an event linked to an
      # "audit and the audit report is not validated yet.
      # The test in the controller new action is disabled.
      event :create_please do
        transition :in_creation => :under_analysis,
                   if: ->(e) { e.required_desc_fields? }
      end

      # Only the owner is authorized
      event :ask_approval do
        # Transition only when in cim_mode, event.acts exist && mandatory fields
        transition :under_analysis => :pending_approval,
                   if: lambda { |e|
                         e.cim_mode? &&
                           e.actions? &&
                           e.required_desc_fields? &&
                           e.required_analysis_fields?
                       }
      end

      # Only the owner is authorized
      event :ask_closure_approval do
        transition :under_analysis => :pending_closure,
                   if: lambda { |e|
                         e.cim_mode? &&
                           e.no_actions? &&
                           e.required_desc_fields? &&
                           e.required_analysis_fields?
                       }
      end

      # Only the owner is authorized
      event :start_processing do
        transition :under_analysis => :completed, unless: :cim_mode?,
                   if: lambda { |e|
                         e.actions? &&
                           e.required_desc_fields? &&
                           e.required_analysis_fields?
                       }
      end

      # Only the owner is authorized
      event :close_event do
        transition :under_analysis => :closed,
                   unless: :cim_mode?,
                   if: lambda { |e|
                         e.no_actions? &&
                           e.required_desc_fields? &&
                           e.required_analysis_fields?
                       }
      end

      # Only the admin is authorized
      event :admin_approve do
        transition :pending_approval => :completed, if: :actions?
      end

      # Only the validator or cim when there is an action plan
      event :approve_action_plan do
        transition :pending_approval => :pending_approval,
                   if: ->(e) { e.actions? && e.pending_approvals? }
        transition :pending_approval => :completed,
                   if: ->(e) { e.actions? && !e.pending_approvals? }
      end

      # Only the validator or cim with no action plan
      event :approve_closure do
        transition :pending_closure => :closed, # if: :no_actions?,
                   # if: :actions_closed_efficient?
                   if: ->(e) { e.no_actions? || e.actions_closed_efficient? }
      end

      # Only the validator or rac is authorized
      event :refuse_action_plan do
        transition :pending_approval => :under_analysis
      end

      # Only the validator or rac is authorized
      event :refuse_closure do
        transition :pending_closure => :under_analysis
      end

      # Only the responsible can run transition force_close.
      # If there is a cim, she/he needs to authorize the force closing.
      # The approval by cim functionality is put on stand-by
      event :force_close do
        # transition :completed => :pending_forced_closure, if: :cim?
        transition :completed => :closed
      end

      # Only the cim can approve a force_close
      # event :approve_force_close do
      #   transition :pending_forced_closure => :closed
      # end

      # Only the cim can approve a force_close
      # event :refuse_force_close do
      #   transition :pending_forced_closure => :under_analysis
      # end

      # No user has access to this action, it is a hook from the closed actions.
      event :auto_close do
        transition :completed => :closed,
                   if: ->(e) { e.no_actions? || e.actions_closed_efficient? }
      end

      # Only the owner is authorized
      event :back_to_analysis do
        transition %i[pending_approval
                      pending_closure
                      pending_forced_closure
                      completed
                      closed] => :under_analysis
      end
    end
    # rubocop:enable Style/HashSyntax
  end

  def actions?
    acts.any?
  end

  def no_actions?
    acts.empty?
  end

  # Are there any actions or are all existing actions closed and efficient?
  def actions_closed_efficient?
    acts.all? do |a|
      a.efficient? && a.closed?
    end
  end
end
