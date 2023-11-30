class FixColumnName < ActiveRecord::Migration[7.1]
  def change
    rename_column :links, :tipo, :type
  end
end
