class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :email_verified
      t.string :name
      t.string :picture
      t.string :given_name
      t.string :family_name
      t.string :locale
      
      t.timestamps
    end
  end
end
