class IncreaseAttributeSizesToMatchFieldValueLimits < ActiveRecord::Migration[5.0]
  def change
    reversible do |direction|
      # Sets each column limit to match column limit for field values:
      #   `65535`
      direction.up do
        change_column :events, :description, :text, limit: 65535
        change_column :events, :analysis, :text, limit: 65535
        change_column :acts, :description, :text, default: nil, limit: 65535
        change_column :audits, :object, :text, limit: 65535
      end

      # The limits used for each field are the previous limits to make this
      # migration fully reversible.  Note that this may raise errors if
      # existing data exceeds the previous limits and may require manually
      # truncating data before reversing this migration.
      direction.down do
        change_column :events, :description, :string, limit: 765
        change_column :events, :analysis, :string, limit: 765
        change_column :acts, :description, :string, default: "", limit: 765
        change_column :audits, :object, :string, limit: 765
      end
    end
  end
end
