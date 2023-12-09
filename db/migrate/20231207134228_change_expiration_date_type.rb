class ChangeExpirationDateType < ActiveRecord::Migration[7.1]
  def change
    change_column :links, :expiration_date, :datetime
  end
end
