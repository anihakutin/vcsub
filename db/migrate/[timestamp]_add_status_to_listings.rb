class AddStatusToListings < ActiveRecord::Migration[7.1]
  def change
    add_column :listings, :status, :string, default: 'pending', null: false
    add_index :listings, :status
  end
end 