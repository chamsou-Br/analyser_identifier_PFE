class CreateInvolvablesRoles < ActiveRecord::Migration[4.2]
  def change
    create_table :involvables_roles do |t|
      t.references :involvable, polymorphic: true, index: true
      t.integer :level, index: true, default: 0, null: false
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
