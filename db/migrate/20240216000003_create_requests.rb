class CreateRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :requests do |t|
      t.string :title, null: false
      t.text :description
      t.string :category
      t.decimal :budget, precision: 10, scale: 2
      t.references :user, null: false, foreign_key: true
      t.string :city
      t.string :state
      t.string :zip_code

      t.timestamps
    end
  end
end 