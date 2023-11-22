class AddTypeToLinks < ActiveRecord::Migration[7.1]
  def change
    add_column :links, :type, :integer, null: false
  end
end
