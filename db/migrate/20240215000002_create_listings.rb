class CreateListings < ActiveRecord::Migration[7.1]
  def change
    create_table :listings do |t|
      t.string :title, null: false
      t.text :description
      t.decimal :price, precision: 15, scale: 2, null: false
      t.string :category
      t.string :condition
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :listings, :category
    add_index :listings, :condition
  end
end 