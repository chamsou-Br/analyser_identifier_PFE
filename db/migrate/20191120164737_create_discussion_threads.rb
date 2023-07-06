# frozen_string_literal: true

class CreateDiscussionThreads < ActiveRecord::Migration[5.0]
  def change
    create_table :discussion_threads do |t|
      t.references :record, index: { unique: true },
                            null: false,
                            polymorphic: true

      t.timestamps
    end
  end
end
