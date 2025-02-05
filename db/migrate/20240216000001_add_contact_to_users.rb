class AddContactToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :contact_preference, :string
    add_column :users, :twitter_handle, :string
  end
end 