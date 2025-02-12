class RemoveInitialValuationFromListings < ActiveRecord::Migration[7.0]
  def change
    remove_column :listings, :initial_valuation, :decimal
  end
end 