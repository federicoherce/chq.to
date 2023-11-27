class RemoveLinkTypeColumn < ActiveRecord::Migration[7.1]
  def change
    remove_column :links, :link_type
  end
end
