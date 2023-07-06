class AddGraphsDocumentsFormFieldToCustomers < ActiveRecord::Migration[5.2]
  def up
    if Rake::Task.task_defined?("data_migration:graphs_documents:add_form_field")
      Rake::Task["data_migration:graphs_documents:add_form_field"].invoke
    else
      puts "graphs and documents could not be found"
    end
  end

  def down 
    puts "graphs and documents go down"
  end
end
