class ModifyDefaultStatusForListings < ActiveRecord::Migration[7.1]
  def up
    change_column_default :listings, :status, from: 'available', to: 'pending'
  end

  def down
    change_column_default :listings, :status, from: 'pending', to: 'available'
  end
end 