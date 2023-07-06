# frozen_string_literal: true

class ChangeGraphsVerifierVerified < ActiveRecord::Migration[4.2]
  def up
    GraphsVerifier.where(verified: nil).update_all({ verified: false })

    change_column :graphs_verifiers,
                  :verified,
                  :boolean,
                  default: false,
                  null: false
  end

  def down
    change_column :graphs_verifiers,
                  :verified,
                  :boolean,
                  default: nil,
                  null: true
  end
end
