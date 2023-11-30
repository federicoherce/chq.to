class AddFieldToLinks < ActiveRecord::Migration[7.1]
  def change
    add_column :links, :nombre, :string
  end
end
