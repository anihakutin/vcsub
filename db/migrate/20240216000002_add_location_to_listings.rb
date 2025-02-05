class AddLocationToListings < ActiveRecord::Migration[7.1]
  def change
    add_column :listings, :city, :string
    add_column :listings, :state, :string
    add_column :listings, :zip_code, :string
  end
end 