# frozen_string_literal: true

#
# Base Pundit policy class from which all other policy classes should inherit
#
class ApplicationPolicy
  # User whose permissions are being evaluated
  # @return [User]
  attr_reader :user

  # Record against which the user's permissions are being evaluated
  # @return [ApplicationRecord]
  attr_reader :record

  def initialize(user, record)
    unless user
      raise Pundit::NotAuthorizedError,
            I18n.t("devise.failure.unauthenticated")
    end

    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  protected

  delegate :improver_admin?, :improver_manager?, :improver_user?,
           :improver_power_user?, :process_admin?, :process_designer?,
           :process_user?, :process_power_user?,
           to: :user

  #
  # Is the `user` the customer owner under the same customer as the `record`?
  #
  # @return [Boolean]
  #
  def customer_owner?
    same_customer? && user.process_admin_owner?
  end

  #
  # Is the `user` a **Process** administrator under the same customer as the
  # `record`?
  #
  # @return [Boolean]
  #
  def customer_process_admin?
    same_customer? && process_admin?
  end

  #
  # Do the `user` and `record` belong to the same customer?
  #
  # @return [Boolean]
  #
  def same_customer?
    if can_compare_customer?
      user.customer_id == record.customer_id
    else
      false
    end
  end

  private

  #
  # Can the customer of the `user` and `record` be compared?  For them to be
  # compareable, the `record` must belong to a customer and one of the `user` or
  # `record` must have such a customer (to avoid `nil` == `nil` comparisons)
  #
  # @return [Boolean]
  #
  def can_compare_customer?
    record.respond_to?(:customer) &&
      (user&.customer_id.present? || record.customer_id.present?)
  end

  #
  # Base `Scope` class to be inhertied by other policy `Scope` classes
  #
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def customer
      user.customer
    end

    def resolve
      scope.all
    end

    # TODO: For the moment repeated in module RiskEntityAdvisor.
    def risk_power_user?
      risk_admin? || risk_manager?
    end

    def risk_admin?
      user.customer.risk_module_admin?(user)
    end

    def risk_manager?
      user.customer.risk_module_manager?(user)
    end
  end
end
