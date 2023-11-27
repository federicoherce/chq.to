class ChangeLinkTypeName < ActiveRecord::Migration[7.1]
  def change
    change_column :links, :tipo_link, :string
  end
end
