class AddReferenceFromStockToBearer < ActiveRecord::Migration[6.1]
  def change
    add_reference :stocks, :bearer,null: true, index: true, foreign_key: true
  end
end
