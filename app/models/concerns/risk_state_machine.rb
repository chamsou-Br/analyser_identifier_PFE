# frozen_string_literal: true

module RiskStateMachine
  extend ActiveSupport::Concern

  included do
    # rubocop:disable Style/HashSyntax
    state_machine :state, initial: :under_analysis do
      ## HOOKS

      after_transition from: :under_analysis do |risk|
        risk.evaluations
            .map(&:submit)
            .each(&:save!)
      end

      after_transition to: %i[completed closed] do |risk|
        next unless risk.active_action_plan

        risk.active_action_plan.acts.map(&:create_please)
      end

      after_transition to: %i[completed under_analysis] do |risk|
        risk.entity_reviews.update_all(active: false)
      end

      after_transition to: :completed do |risk|
        risk.active_action_plan&.freeze_plan
      end

      after_transition to: :under_analysis do |risk|
        next if risk.active_action_plan
        next unless risk.latest_frozen_plan

        risk.action_plans << ActionPlan.new(acts: risk.latest_frozen_plan.acts)
      end

      ## TRANSITIONS

      # Only the owner is authorized
      # Transition only when validators?, risk.current_action_plan.acts exist
      # && mandatory fields.
      # Response strategy is one of transfer, mitigate or remove.
      event :ask_approval do
        weight 128
        transition :under_analysis => :pending_approval,
                   if: :valid_ask_approval?
      end

      # Only the owner is authorized
      # Transition only when validators? && mandatory fields
      # Response strategy is one of accept_as_is or defer_processing
      event :ask_closure_approval do
        weight 64
        transition :under_analysis => :pending_closure,
                   if: :valid_ask_closure_approval?
      end

      # Only the owner is authorized
      # Transition only when no_validators?, risk.current_action_plan.acts
      # exist && mandatory fields.
      # Response strategy is one of transfer, mitigate or remove.
      event :start_processing do
        weight 4
        transition :under_analysis => :completed,
                   if: :valid_start_processing?
      end

      # Only the owner is authorized
      # Transition only when no_validators? && mandatory fields
      # Response strategy is one of accept_as_is or defer_processing
      event :close_risk do
        weight 16
        transition :under_analysis => :closed,
                   if: :valid_close_risk?
      end

      # Only the admin is authorized
      # Transition only when risk.current_action_plan.acts exist
      # && mandatory fields.
      # Response strategy is one of transfer, mitigate or remove.
      #
      # TODO: not sure why is this asked... already done for moving to
      # pending_approval...
      #
      event :admin_approve do
        admin_only
        weight 8
        requires_review

        transition :pending_approval => :completed,
                   if: :valid_admin_approve?
      end

      # Only the validator is authorized
      # Transition only when risk.current_action_plan.acts exist
      event :approve_action_plan do
        weight 64
        requires_review

        # TEMP: validators
        # For 3.0.0, only one validator is allowed. Allowing more needs
        # a change in the front-end and implementation of entity_review as a
        # decision maker for the workflow transition.
        #
        # transition :pending_approval => :pending_approval,
        #            if: :can_approve?
        transition :pending_approval => :completed,
                   if: :can_approve_and_transition?
      end

      # Only the validator with no action plan
      event :approve_closure do
        weight 64
        transition :pending_closure => :closed,
                   if: :valid_approve_closure?
      end

      # Only the validator when there is an action plan
      event :refuse_action_plan do
        weight 32
        requires_comment
        requires_review

        transition :pending_approval => :under_analysis,
                   if: :valid_refuse_action_plan?
      end

      # Only the validator is authorized
      event :refuse_closure do
        weight 32
        requires_comment

        transition :pending_closure => :under_analysis,
                   if: :valid_refuse_closure?
      end

      # TODO: who is authorized?
      event :back_to_analysis do
        requires_comment
        weight 2

        transition %i[
          pending_approval pending_closure completed closed
        ] => :under_analysis
      end
    end
    # rubocop:enable Style/HashSyntax
  end

  #
  # Can the risk be submitted for review?
  #
  # @returns [Boolean]
  # @note The predicates used in this method have a side-effect of appending
  #   `:state_machine` errors.  Because of this, these predicates cannot be
  #   short-circuited.
  #
  def valid_ask_approval?
    # TEMP: validators
    # check_validators = validators?
    check_validators = validator_exists?
    # check_actions = actions?
    check_strategy = strategy_to_complete?
    check_required_fields = required_initial_fields?
    check_validators && check_strategy && check_required_fields
  end

  #
  # Can the risk be submitted for closure review?
  #
  # @returns [Boolean]
  # @note The predicates used in this method have a side-effect of appending
  #   `:state_machine` errors.  Because of this, these predicates cannot be
  #   short-circuited.
  #
  def valid_ask_closure_approval?
    # TEMP: validators
    # check_validators = validators?
    check_validators = validator_exists?
    # check_no_actions = no_actions?
    check_strategy = strategy_to_close?
    check_required_fields = required_initial_fields?
    check_validators && check_strategy && check_required_fields
  end

  #
  # Can the risk be started?
  #
  # @returns [Boolean]
  # @note The predicates used in this method have a side-effect of appending
  #   `:state_machine` errors.  Because of this, these predicates cannot be
  #   short-circuited.
  #
  def valid_start_processing?
    # TEMP: validators
    # check_no_validators = no_validators?
    check_no_validators = no_validator_exists?
    # check_actions = actions?
    check_strategy = strategy_to_complete?
    check_required_fields = required_initial_fields?
    check_no_validators && check_strategy && check_required_fields
  end

  #
  # Can a risk be closed?
  #
  # @returns [Boolean]
  # @note The predicates used in this method have a side-effect of appending
  #   `:state_machine` errors.  Because of this, these predicates cannot be
  #   short-circuited.
  #
  def valid_close_risk?
    # TEMP: validators
    # check_no_validators = no_validators?
    check_no_validators = no_validator_exists?
    # check_no_actions = no_actions?
    check_strategy = strategy_to_close?
    check_required_fields = required_initial_fields?
    check_no_validators && check_strategy && check_required_fields
  end

  #
  # Can the risk be approved by an administrator?
  #
  # @returns [Boolean]
  # @note The predicate used in this method has a side-effect of appending
  #   `:state_machine` errors.
  #
  def valid_admin_approve?
    # actions?
    strategy_to_complete?
  end

  #
  # Can the risk be approve by a validator?
  #
  # @returns [Boolean]
  # @note The predicates used in this method have a side-effect of appending
  #   `:state_machine` errors.  Because of this, these predicates cannot be
  #   short-circuited.
  #
  def valid_approve_closure?
    # TEMP: validators
    # check_validators = validators?
    check_validators = validator_exists?
    # check_no_actions = no_actions?
    check_strategy = strategy_to_close?
    check_validators && check_strategy
  end

  #
  # Can the risk's action plan be rejected by a validator?
  #
  # @returns [Boolean]
  # @note The predicates used in this method have a side-effect of appending
  #   `:state_machine` errors.  Because of this, these predicates cannot be
  #   short-circuited.
  #
  def valid_refuse_action_plan?
    # TEMP: validators
    # check_validators = validators?
    check_validators = validator_exists?
    # check_actions = actions?
    check_strategy = strategy_to_complete?
    check_validators && check_strategy
  end

  #
  # Can the risk's closure be refused by a validator?
  #
  # @returns [Boolean]
  # @note The predicates used in this method have a side-effect of appending
  #   `:state_machine` errors.  Because of this, these predicates cannot be
  #   short-circuited.
  #
  def valid_refuse_closure?
    # TEMP: validators
    # check_validators = validators?
    check_validators = validator_exists?
    # check_no_actions = no_actions?
    check_strategy = strategy_to_close?
    check_validators && check_strategy
  end

  #
  # Can the risk be approved by a validator?
  #
  # @returns [Boolean]
  # @note The predicates used in this method have a side-effect of appending
  #   `:state_machine` errors.  Because of this, these predicates cannot be
  #   short-circuited.
  #
  def can_approve?
    # TEMP: validators
    # check_validators = validators?
    check_validators = validator_exists?
    # check_actions = actions?
    check_strategy = strategy_to_complete?
    # TODO: Pending implemention of more than one validator
    check_pending_approvals = true
    check_validators && check_strategy && check_pending_approvals
  end

  #
  # Can the risk be approved and advanced in workflow by a validator?
  #
  # @returns [Boolean]
  #
  def can_approve_and_transition?
    # TEMP: validators
    # check_validators = validators?
    check_validators = validator_exists?
    # check_actions = actions?
    check_strategy = strategy_to_complete?
    # TODO: Pending implemention of more than one validator
    # check_pending_approvals = false
    # check_validators && check_strategy && check_pending_approvals
    check_validators && check_strategy
  end

  #
  # Does the Risk have an action plan with actions?
  #
  # @returns [Boolean]
  # @note Appends `:state_machine` errors if there are no actions
  #
  def actions?
    # TODO: test this method, if it eventually gets used. Otherwise this smells
    # as dead code in the making.
    #
    # This condition is not enough, the response strategy of the last
    # evaluation needs to be combined into the decision along with the
    # presence of actions, to allow or not a transition.
    #
    if current_action.plan.acts.empty?
      errors.add :state_machine,
                 I18n.t("risk.transition_blockers.missing_action_plan")
    end
    true
  end

  def strategy_to_complete?
    case response_strategy
    when "accept_as_is", "defer_processing"
      errors.add :state_machine,
                 I18n.t("risk.transition_blockers.incorrect_response_strategy")
      return false
    when nil
      errors.add :state_machine,
                 I18n.t("risk.transition_blockers.missing_evaluation")
      return false
    end

    # response_strategy is one of "transfer", "mitigate", "remove", which
    # requires the presence of an action plan with actions.
    #
    # TODO: there is surely a more clever way to write this if, however like
    # this it is easy to read.
    #
    if current_action_plan.nil? || current_action_plan.acts.empty?
      errors.add :state_machine,
                 I18n.t("risk.transition_blockers.missing_action_plan")
      return false

    end
    true
  end

  # Does the Risk not have action plan with actions?
  #
  # @returns [Boolean]
  # @note Appends `:state_machine` errors if there are any actions
  #
  def no_actions?
    # TODO: test this method, if it eventually gets used. Otherwise this smells
    # as dead code in the making.
    #
    # This condition is not enough, the response strategy of the last
    # evaluation needs to be combined into the decision to allow or not a
    # transition.
    #
    if current_action.plan.acts.any?
      errors.add :state_machine,
                 I18n.t("risk.transition_blockers.has_action_plan")
    end
    # TODO: what should happen if the current_action_plan is nil?
    current_action_plan.acts.empty?
  end

  def strategy_to_close?
    case response_strategy
    when "accept_as_is", "defer_processing"
      return true
    when "transfer", "mitigate", "remove"
      errors.add :state_machine,
                 I18n.t("risk.transition_blockers.incorrect_response_strategy")
    else
      errors.add :state_machine,
                 I18n.t("risk.transition_blockers.missing_evaluation")
    end
    false
  end

  def actions_closed_efficient?
    return true unless current_action_plan

    current_action_plan&.acts&.all? do |action|
      action.efficient? && action.closed?
    end
  end

  #
  # Does the Risk have any validators assigned to it?  Having at least 1
  # validator assigned to the risk implies that the risk will need to be
  # validated.
  #
  # @returns [Boolean]
  # @note Appends `:state_machine` errors if there are no validators assigned to
  #   the risk
  #
  # TEMP: validators
  # Temporarality turning to single responsibility
  # def validators?
  #   if validators.empty?
  #     errors.add :state_machine,
  #                I18n.t("risk.transition_blockers.missing_validator")
  #   end
  #   validators.any?
  # end
  #
  def validator_exists?
    has_validator = actors.exists?(responsibility: "validator")
    unless has_validator
      errors.add :state_machine,
                 I18n.t("risk.transition_blockers.missing_validator")
    end
    has_validator
  end

  #
  # Does the Risk not have any validators assigned to it?  Having no validators
  # assigned to the risk implies that the risk will not need to be validated.
  #
  # @returns [Boolean]
  # @note Appends `:state_machine` errors if there are any validators assigned
  #   to the risk
  #
  # TEMP: validators
  # Temporarality turning to single responsibility
  # def no_validators?
  #   if validators.any?
  #     errors.add :state_machine,
  #                I18n.t("risk.transition_blockers.has_validator")
  #   end
  #   validators.empty?
  # end
  #
  def no_validator_exists?
    has_validator = actors.exists?(responsibility: "validator")
    if has_validator
      errors.add :state_machine,
                 I18n.t("risk.transition_blockers.has_validator")
    end
    !has_validator
  end

  def pending_approvals?
    # TODO: implement using entity_review
    # TODO: This is the definition for the event. I hate to duplicate the
    # existing logic. The way the responses are handled in improver is rather
    # convoluted.
    # (event_validators.pluck(:response) +
    #   cims_responses.pluck(:response)).include? nil
    false
  end

  #
  # Does the risk have all of its initially required fields filled out?
  #
  # @returns [Boolean]
  # @todo test when testing graphQL payload.
  def required_initial_fields?
    [required_risk_fields?,
     required_evaluation_fields?,
     required_mitigation_fields?].all?
  end

  def required_risk_fields?
    [required_fields?("properties"),
     required_fields?("cause_effect"),
     required_fields?("interactions"),
     required_fields?("disasters"),
     required_fields?("action_plan")].all?
  end

  def required_evaluation_fields?
    # TODO: might need to do the same as for the mitigation strategy, unless it
    # is ensured that only one evaluation per cycle exists.
    #
    return true unless last_evaluation

    eval_system = last_evaluation.evaluation_system

    [last_evaluation&.required_fields_agnostic?("impact_gravity", eval_system),
     last_evaluation&.required_fields_agnostic?("likelihood", eval_system),
     last_evaluation&.required_fields_agnostic?("criticality", eval_system),
     last_evaluation&.required_fields_agnostic?("response", eval_system)].all?
  end

  def required_mitigation_fields?
    # TODO: this is the abridged version. The real version needs to loop over
    # all the mitigation strategies of the risk and make sure that all the
    # required fields are completed.
    #
    return true unless mitigation_strategies.last

    mitigation_strategies.last&.required_fields?("description")
  end
end
