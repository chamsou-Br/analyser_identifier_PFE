class AddTitlesToEvalSystemOnEmpty < ActiveRecord::Migration[5.1]
  def change
    Rake::Task["data_migration:evaluation_system_title:add_default_titles"].invoke
  end
end
