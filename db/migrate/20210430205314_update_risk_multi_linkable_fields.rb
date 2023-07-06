class UpdateRiskMultiLinkableFields < ActiveRecord::Migration[5.1]
  def change
    Rake::Task["data_migration:risk_form_fields:update_multi_linkable_fields"].invoke
  end
end
