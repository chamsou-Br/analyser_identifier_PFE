# frozen_string_literal: true

module EvalSystemStateMachine
  extend ActiveSupport::Concern

  # The state in the evaluation_system model is an enum as follows:
  # enum state: { draft: 0,
  #               applicable: 1, (to avoid the clash with attr active
  #               archived: 2 }

  included do
    # rubocop:disable Style/HashSyntax

    # The only place a brand new evaluation system is created, is when a
    # customer acquires the risk module. In such case we want the evaluation
    # system to be ready to use. Subsequent systems are cloned from the active
    # one, and there the state must be manually update to `draft`.
    #
    state_machine :state, initial: :applicable do
      ## TRANSITION HOOKS
      before_transition to: :applicable do |eval_system|
        customer = eval_system.customer
        prev_eval_system = customer.applicable_evaluation_system
        prev_eval_system&.archive!
      end

      ## TRANSITIONS

      event :activate do
        transition :draft => :applicable,
                   if: ->(es) { es.valid_scales? && es.valid_labels? }
      end

      event :archive do
        transition :applicable => :archived
      end
    end
    # rubocop:enable Style/HashSyntax
  end

  # This method verifies that all ratings have labels.
  # When any of the labels of the rating is found to be blank, an ActiveModel
  # error is added to :base and false is returned. True is returned otherwise.
  #
  def valid_labels?
    if impact_scale.ratings.map(&:valid_label?).all? &&
       likelihood_scale.ratings.map(&:valid_label?).all? &&
       threat_level_scale.ratings.map(&:valid_label?).all?
      return true
    end

    errors.add(:base, "Rating labels cannot be blank.")
    false
  end

  # This method verifies that the ratings of one scale have different values.
  # When the same label is found for the same scale, an ActiveModel error is
  # added to :base and false is returned. True is returned otherwise.
  #
  def valid_scales?
    if impact_scale.unique_value_per_scale? &&
       likelihood_scale.unique_value_per_scale? &&
       threat_level_scale.unique_value_per_scale?
      return true
    end

    errors.add(:base, "Rating values for the same scale must be different.")
    false
  end
end
