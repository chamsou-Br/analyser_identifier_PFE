class CreateTaskFlags < ActiveRecord::Migration[4.2]
  def change
    create_table :task_flags do |t|
      t.integer :user_id
      t.integer :taskable_id
      t.string :taskable_type
      t.boolean :important
      t.timestamps
    end
  end
end
