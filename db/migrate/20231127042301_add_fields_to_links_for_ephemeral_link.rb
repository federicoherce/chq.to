class AddFieldsToLinksForEphemeralLink < ActiveRecord::Migration[7.1]
  def change
    add_column :links, :entered, :boolean
  end
end
