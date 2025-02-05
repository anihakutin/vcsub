class AddValuationAndRunwayToListings < ActiveRecord::Migration[7.0]
  def change
    add_column :listings, :initial_valuation, :decimal, precision: 15, scale: 2
    add_column :listings, :runway_end_date, :date
  end
end 