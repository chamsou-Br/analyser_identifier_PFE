class SetSvgUseFlagTrueByDefault < ActiveRecord::Migration[4.2]
  def change
  	change_column :flags, :svg_use, :boolean, :default => true
  	Flag.all.each do |flag|
  		flag.svg_use = true
      flag.save
  	end
  end
end
