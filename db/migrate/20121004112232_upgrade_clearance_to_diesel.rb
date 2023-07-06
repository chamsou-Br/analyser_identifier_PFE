class UpgradeClearanceToDiesel < ActiveRecord::Migration[4.2]
  def self.up
    change_table :users  do |t|
      t.string :encrypted_password, :limit => 128
      t.string :confirmation_token, :limit => 128
      t.string :remember_token, :limit => 128
    end

    add_index :users, :email
    add_index :users, :remember_token
  end

  def self.down
    remove_index :users, :email
    remove_index :users, :remember_token
    
    change_table :users do |t|
      t.remove :encrypted_password,:confirmation_token,:remember_token
    end
    
  end
end
