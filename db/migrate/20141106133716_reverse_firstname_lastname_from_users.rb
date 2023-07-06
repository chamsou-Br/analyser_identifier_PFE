class ReverseFirstnameLastnameFromUsers < ActiveRecord::Migration[4.2]
  def change
    change_table :users do |t|
      t.rename :firstname, :cache_firstname
      t.rename :lastname, :firstname
      t.rename :cache_firstname, :lastname
    end
  end
end
