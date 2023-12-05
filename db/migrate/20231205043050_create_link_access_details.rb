class CreateLinkAccessDetails < ActiveRecord::Migration[7.1]
  def change
    create_table :link_access_details do |t|
      t.references :link, null: false, foreign_key: true
      t.datetime :access_datetime
      t.string :ip_address

      t.timestamps
    end
  end
end
