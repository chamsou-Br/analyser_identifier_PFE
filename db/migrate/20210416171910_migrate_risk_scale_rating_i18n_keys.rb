# frozen_string_literal: true

# This data migration is intended to address I18n issues raised in #2394
# regarding an update to various translation keys.
class MigrateRiskScaleRatingI18nKeys < ActiveRecord::Migration[5.1]
  def up
    Rake::Task["data_migration:risk_scale_i18n_key_renames"].invoke
  end

  def down
    puts "Do nothing"
  end
end
