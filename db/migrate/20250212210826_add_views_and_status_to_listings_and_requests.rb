class AddViewsAndStatusToListingsAndRequests < ActiveRecord::Migration[7.1]
  def change
    add_column :listings, :views_count, :integer, default: 0
    add_column :listings, :status, :string, default: 'available'
    add_column :requests, :views_count, :integer, default: 0
    add_column :requests, :status, :string, default: 'open'
    
    add_index :listings, :status
    add_index :requests, :status
  end
end
