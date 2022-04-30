class AddDeletedAtToStock < ActiveRecord::Migration[6.1]
  def change
    add_column :stocks, :deleted_at, :datetime
  end
end
