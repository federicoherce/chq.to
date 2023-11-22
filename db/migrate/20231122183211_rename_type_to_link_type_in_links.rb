class RenameTypeToLinkTypeInLinks < ActiveRecord::Migration[7.1]
  def change
    rename_column :links, :type, :link_type
  end
end
