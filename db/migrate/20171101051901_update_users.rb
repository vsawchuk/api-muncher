class UpdateUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :email_verified
    remove_column :users, :name
    remove_column :users, :picture
    remove_column :users, :given_name
    remove_column :users, :family_name
    remove_column :users, :locale

    add_column :users, :uid, :string, null: false
    add_column :users, :provider, :string, null: false
    add_column :users, :username, :string
  end
end
