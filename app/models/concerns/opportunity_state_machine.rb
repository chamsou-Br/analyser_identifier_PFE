# frozen_string_literal: true

module OpportunityStateMachine
  extend ActiveSupport::Concern

  included do
    # rubocop:disable Style/HashSyntax
    state_machine :state, initial: :under_analysis do
      #
      ## TRANSITIONS
      # TODO for the moment it copies the transitions from risk. Missing still
      # is to define who has access to the transition, and are comments needed
      # for particular transitions. Also, there are no hooks defined yet.
      #
      event :ask_approval do
        weight 128
        transition :under_analysis => :pending_approval
      end

      event :ask_closure_approval do
        weight 64
        transition :under_analysis => :pending_closure
      end

      event :start_processing do
        weight 4
        transition :under_analysis => :completed
      end

      event :close_opportunity do
        weight 16
        transition :under_analysis => :closed
      end

      event :admin_approve do
        admin_only
        weight 8
        transition :pending_approval => :completed
      end

      event :approve_action_plan do
        weight 64
        requires_review

        transition :pending_approval => :completed
      end

      event :approve_closure do
        weight 64
        transition :pending_closure => :closed
      end

      event :refuse_action_plan do
        weight 32
        transition :pending_approval => :under_analysis
      end

      event :refuse_closure do
        weight 32

        transition :pending_closure => :under_analysis
      end

      event :back_to_analysis do
        weight 2

        transition %i[
          pending_approval pending_closure completed closed
        ] => :under_analysis
      end
    end
    # rubocop:enable Style/HashSyntax
  end
end
