class RemoveRunwayEndDateFromListings < ActiveRecord::Migration[7.0]
  def change
    remove_column :listings, :runway_end_date, :date
  end
end 