class CreateReviewHistories < ActiveRecord::Migration[4.2]
  def change
    create_table :review_histories do |t|
      t.date :review_date
      t.references :reviewer, references: :users
      t.references :groupgraph, references: :groupgraphs

      t.timestamps null: false
    end
  end
end
