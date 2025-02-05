class AddProfileFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :name, :string
    add_column :users, :company_name, :string
    add_column :users, :funded_by, :string
    add_column :users, :funding_raised, :decimal, precision: 15, scale: 2
  end
end 