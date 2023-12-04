class CreateLinkStatistics < ActiveRecord::Migration[7.1]
  def change
    create_table :link_statistics do |t|
      t.references :link, null: false, foreign_key: true
      t.date :access_date
      t.integer :access_count

      t.timestamps
    end
  end
end
