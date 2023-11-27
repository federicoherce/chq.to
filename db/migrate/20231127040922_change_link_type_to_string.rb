class ChangeLinkTypeToString < ActiveRecord::Migration[7.1]
  def change
    change_column :links, :link_type, :string
  end
end
