class AddDefaultValueToAction < ActiveRecord::Migration[5.0]
  def up
    change_column_default(:acts, :title, from: nil, to: "")
    change_column_default(:acts, :description, from: nil, to: "")
    change_column_default(:acts, :reference, from: nil, to: "")
    change_column_default(:acts, :reference_prefix, from: nil, to: "")
    change_column_default(:acts, :reference_suffix, from: nil, to: "")
  end
end

