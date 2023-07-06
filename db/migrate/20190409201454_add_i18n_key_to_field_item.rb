class AddI18nKeyToFieldItem < ActiveRecord::Migration[5.0]
  def change
    add_column :field_items, :i18n_key, :string
  end
end
