# frozen_string_literal: true

class TagPolicy < ApplicationPolicy
  alias tag record

  def action?
    process_power_user?
  end

  def show?
    true
  end
end
