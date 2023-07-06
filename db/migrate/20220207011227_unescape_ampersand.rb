class UnescapeAmpersand < ActiveRecord::Migration[5.2]
  def up
    if Rake::Task.task_defined?("data_migration:sanitizeable:unescape_ampersand")
      Rake::Task["data_migration:sanitizeable:unescape_ampersand"].invoke
    else
      puts "UnescapeAmpersand ain't no more"
    end
  end

  def down
    puts "Escaping inescapable"
  end
end
