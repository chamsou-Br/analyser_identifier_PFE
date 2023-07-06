class ChangeLimitForTextInTolkPhrases < ActiveRecord::Migration[5.0]
  # For some reason (perhaps the converion of the tables to utf-8) mysql
  # "updated" the type of these fields from TEXT (65,535 bytes) to
  # MEDIUMTEXT (16,777,215 bytes) which is ridiculously big.
  # Here, setting back the default to TEXT for both up and down methods 
  # to allow for a rollback without errors. 

  def up
    change_column :tolk_phrases, :key, :text, limit: 65535
    change_column :tolk_translations, :text, :text, limit: 65535
    change_column :tolk_translations, :previous_text, :text, limit: 65535
  end

  def down
    change_column :tolk_phrases, :key, :text, limit: 65535
    change_column :tolk_translations, :text, :text, limit: 65535
    change_column :tolk_translations, :previous_text, :text, limit: 65535
  end
end
