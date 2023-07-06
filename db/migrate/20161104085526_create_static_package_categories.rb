class CreateStaticPackageCategories < ActiveRecord::Migration[4.2]
  def up
    create_table :static_package_categories do |t|
      t.string :name
      t.integer :family

      t.timestamps null: false
    end

    StaticPackageCategory.create([
      {name: 'rd', family: StaticPackageCategory.families[:operation]},
      {name: 'production', family: StaticPackageCategory.families[:operation]},
      {name: 'sales', family: StaticPackageCategory.families[:operation]},
      {name: 'customer_relationship', family: StaticPackageCategory.families[:operation]},
      {name: 'suppliers_relationship', family: StaticPackageCategory.families[:operation]},
      {name: 'human_resources', family: StaticPackageCategory.families[:support]},
      {name: 'supply_chain', family: StaticPackageCategory.families[:support]},
      {name: 'it', family: StaticPackageCategory.families[:support]},
      {name: 'finance', family: StaticPackageCategory.families[:support]},
      {name: 'marketing_communication', family: StaticPackageCategory.families[:support]},
      {name: 'qhse_compliance', family: StaticPackageCategory.families[:management]},
      {name: 'strategy_steering', family: StaticPackageCategory.families[:management]},
      {name: 'performance_management', family: StaticPackageCategory.families[:management]}
    ])
  end

  def down
    drop_table :static_package_categories
  end
end
