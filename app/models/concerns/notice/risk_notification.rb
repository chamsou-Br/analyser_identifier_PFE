# frozen_string_literal: true

module Notice
  #
  # Including the **RiskNotification** concern makes the model capable of
  # sending notificatons on triggering events. This concern is Risk specific.
  #
  module RiskNotification
    extend ActiveSupport::Concern
    include Noticeable

    # TODO: `Rails.application.routes.url_helpers` is used and included in many
    # places. Searching for the string shows many occurrences of this `include`.
    # We need one source of truth. Issue #2413.
    #
    # Returns the full url of the object to be embedded in an email body and be
    # able to access the object with one click.
    # @note This behaviour might change when the `already_read` flag is
    #   implemented.
    # @return [String]
    #
    def full_url
      helpers = Rails.application.routes.url_helpers
      helpers.risks_risk_url(self, host: customer.url)
    end

    # Objects for which notification are triggered, may have different titles
    # or description. The method is to be called from the view of the email
    # body.
    #
    # @return [String] Whatever this object defines as its best description or
    #   title to be included in an email.
    # @note @ngelinas had talk and perhaps created an issue around this topic.
    #
    def my_description
      field_value_value("title")
    end

    # Notification when a Risk is created, with the following characteristics:
    #   author --> is the sender
    #   owner --> gets :create_request (risk waiting for analysis)
    #   validator --> gets :create_info (declared risk)
    #
    # @param sender [User]
    #
    def notify_on_create(sender)
      dispatch_notif_workflow(roles: [:owner],
                              sender: sender,
                              category: :create_request)

      dispatch_notif_workflow(roles: [:validator],
                              sender: sender,
                              category: :create_info)
    end

    # Notification when the validation of the action plan of the Risk is
    # requested, with the following characteristics:
    #   owner --> is the sender
    #   validator --> gets :ask_approval_request
    #   author, contributor --> get :ask_approval_info
    #
    # @param sender [User]
    #
    def notify_on_ask_approval(sender)
      dispatch_notif_workflow(roles: [:validator],
                              sender: sender,
                              category: :ask_approval_request)

      dispatch_notif_workflow(roles: %i[author contributor],
                              sender: sender,
                              category: :ask_approval_info)
    end

    # Notification when the closure without action pland of the Risk is
    # requested, with the following characteristics:
    #   owner --> is the sender
    #   validator --> gets :ask_closure_approval_request
    #   author, contributor --> get :ask_closure_approval_info
    #
    # @param sender [User]
    #
    def notify_on_ask_closure_approval(sender)
      dispatch_notif_workflow(roles: [:validator],
                              sender: sender,
                              category: :ask_closure_approval_request)

      dispatch_notif_workflow(roles: %i[author contributor],
                              sender: sender,
                              category: :ask_closure_approval_info)
    end

    # Notification when the action plan of the Risk is approved, with ther
    # following characteristics:
    #   validator --> is the sender
    #   all other users with a role --> get :approve_action_plan_info
    #
    # @param sender [User]
    #
    def notify_on_approve_action_plan(sender)
      dispatch_notif_workflow(roles: %i[owner author validator contributor],
                              sender: sender,
                              category: :approve_action_plan_info)
    end

    # TODO: pending testing as the translation keys are the same as for
    # :approve_action_plan_info
    #
    # Notification when the action plan of the Risk is approved by an admin,
    # with the following characteristics:
    #   admin --> is the sender
    #   all other users with a role --> get :approve_action_plan_info
    #
    # @param sender [User]
    #
    def notify_on_admin_approve(sender)
      notify_on_approve_action_plan(sender)
    end

    # Notification when the closure of the Risk is requested, with the
    # following characteristics:
    #   validator --> is the sender
    #   all other users with a role --> get :approve_closure_info
    #
    # @param sender [User]
    #
    def notify_on_approve_closure(sender)
      dispatch_notif_workflow(roles: %i[owner author validator contributor],
                              sender: sender,
                              category: :approve_closure_info)
    end

    # Notification when the closure of the Risk is approved, with the
    # following characteristics:
    #   owner --> is the sender and there are no validators for the entity
    #   all other users with a role --> get :close_risk_info
    #
    # @param sender [User]
    #
    def notify_on_close_risk(sender)
      dispatch_notif_workflow(roles: %i[author contributor],
                              sender: sender,
                              category: :close_risk_info)
    end

    # Notification when the refusal of the action plan of the Risk,
    # with the following characteristics:
    #   validator --> is the sender
    #   all other users with a role --> get :refuse_action_plan_info
    #
    # @param sender [User]
    #
    def notify_on_refuse_action_plan(sender)
      dispatch_notif_workflow(roles: %i[owner author validator contributor],
                              sender: sender,
                              category: :refuse_action_plan_info)
    end

    # Notification when the refusal for closure of the Risk, with the
    # following characteristics:
    #   validator --> is the sender
    #   all other users with a role --> get :refuse_closure_info
    #
    # @param sender [User]
    #
    def notify_on_refuse_closure(sender)
      dispatch_notif_workflow(roles: %i[owner author validator contributor],
                              sender: sender,
                              category: :refuse_closure_info)
    end

    # Notification when the Risk processing is started, with the following
    # characteristics:
    #   owner --> is the sender and there are no validators for the entity
    #   all other users with a role --> get :start_processing_info
    #
    # @param sender [User]
    #
    def notify_on_start_processing(sender)
      dispatch_notif_workflow(roles: %i[author contributor],
                              sender: sender,
                              category: :start_processing_info)
    end

    # Notification when the Risk has been processed and is back to analysis,
    # (usually automatically because the actions have been completed
    # efficiently) with the following characteristics:
    #   author --> is the sender
    #   owner --> gets :update_evaluation_request
    #   all other users with a role --> get :update_evaluation_info
    #
    # @param sender [User]
    #
    def notify_on_update_evaluation(sender)
      dispatch_notif_workflow(roles: [:owner],
                              sender: sender,
                              category: :update_evaluation_request)
      dispatch_notif_workflow(roles: %i[author validator contributor],
                              sender: sender,
                              category: :update_evaluation_info)
    end

    # Notification when the Risk is back to analysis and its processing is not
    # necessarily completed, with the following characteristics:
    #   owner or validator --> sender
    #   owner --> gets :update_evaluation_request
    #   all other users with a role --> get :update_evaluation_info
    #
    # @param sender [User]
    #
    def notify_on_back_to_analysis(sender)
      dispatch_notif_workflow(roles: [:owner],
                              sender: sender,
                              category: :back_to_analysis_request)
      dispatch_notif_workflow(roles: %i[author validator contributor],
                              sender: sender,
                              category: :back_to_analysis_info)
    end
  end
end
