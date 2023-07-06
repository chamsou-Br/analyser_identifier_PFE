# frozen_string_literal: true

class ChangeGraphsApproverApproved < ActiveRecord::Migration[4.2]
  def up
    GraphsApprover.where(approved: nil).update_all({ approved: false })
    change_column :graphs_approvers,
                  :approved,
                  :boolean,
                  default: false,
                  null: false
  end

  def down
    change_column :graphs_approvers,
                  :approved,
                  :boolean,
                  default: nil,
                  null: true
  end
end
