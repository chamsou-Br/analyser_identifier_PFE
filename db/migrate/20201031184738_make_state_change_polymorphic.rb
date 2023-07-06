# frozen_string_literal: true

class MakeStateChangePolymorphic < ActiveRecord::Migration[5.1]
  def change
    # As there are no existing risk state changes, it is safe to remove the
    # risk reference and add a new polymorphic reference instead
    remove_foreign_key :risk_state_changes, :risks
    remove_column :risk_state_changes, :risk_id, :integer
    add_reference :risk_state_changes, :entity, null: false,
                                                polymorphic: true

    # Comments will serve as the comments users provide when advancing the
    # workflow of a given entity.  Some such advances require a message to be
    # provided.
    add_column :risk_state_changes, :comment, :string

    # It seems more sensible to describe the user responsible for a change in
    # state as its author
    rename_column :risk_state_changes, :user_id, :author_id

    # Renames the current `state` column to `from` and adds `to` to more
    # completely represent the change of state for a given entity
    rename_column :risk_state_changes, :state, :from
    add_column :risk_state_changes, :to, :string, null: false

    # This rename is to make this table no longer be constrained articifically
    # to risks.
    rename_table :risk_state_changes, :state_machines_state_changes
  end
end
