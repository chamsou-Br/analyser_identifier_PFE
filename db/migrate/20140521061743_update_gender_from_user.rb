class UpdateGenderFromUser < ActiveRecord::Migration[4.2]
  def change
    change_column :users, :gender, :string, :default => "man"
    User.where(gender: 'Homme').update_all(gender: 'man')
    User.where(gender: 'Femme').update_all(gender: 'woman')
  end
end
