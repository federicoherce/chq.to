class RenameLinkStatisticsTable < ActiveRecord::Migration[7.1]
  def change
    rename_table :links_per_day, :link_statistics
  end
end
