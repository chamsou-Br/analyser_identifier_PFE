class RemoveIdentificationFromMitigation < ActiveRecord::Migration[5.1]
  def change
    remove_reference :mitigations, :identification, foreign_key: true
  end
end
