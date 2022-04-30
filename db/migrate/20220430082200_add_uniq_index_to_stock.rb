class AddUniqIndexToStock < ActiveRecord::Migration[6.1]
  def change
    add_index :stocks, :name, unique: true, where: 'deleted_at IS NULL'
  end
end
