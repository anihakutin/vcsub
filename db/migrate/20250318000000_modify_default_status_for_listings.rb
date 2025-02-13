class ModifyDefaultStatusForListings < ActiveRecord::Migration[7.1]
  def up
    change_column_default :listings, :status, from: 'available', to: 'pending'
    change_column_default :requests, :status, from: 'open', to: 'pending'
  end

  def down
    change_column_default :listings, :status, from: 'pending', to: 'available'
    change_column_default :requests, :status, from: 'pending', to: 'open'
  end
end 