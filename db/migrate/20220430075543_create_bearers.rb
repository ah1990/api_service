class CreateBearers < ActiveRecord::Migration[6.1]
  def change
    create_table :bearers do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
