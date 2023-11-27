class AddLinkableToLinks < ActiveRecord::Migration[7.1]
  def change
    add_column :links, :linkable_type, :string
    add_column :links, :linkable_id, :integer
  end
end
