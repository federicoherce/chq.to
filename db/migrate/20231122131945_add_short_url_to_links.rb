class AddShortUrlToLinks < ActiveRecord::Migration[7.1]
  def change
    add_column :links, :short_url, :string
  end
end
