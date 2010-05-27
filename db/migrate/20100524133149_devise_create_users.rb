class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    rename_column :users, :password, :encrypted_password
    change_column :actors, :email, :string, :null => false, :default => "", :limit => 256
    change_column :users, :encrypted_password, :string, :limit => 128, :null => false, :default => ""
    add_column :users, :password_salt, :string, :null => false, :default => ""
    add_column :users, :confirmation_token, :string
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime
    add_column :users, :reset_password_token, :string

    add_index :actors, :email,               :unique => true
    add_index :actors, :permalink,           :unique => true
    add_index :users, :confirmation_token,   :unique => true
    add_index :users, :reset_password_token, :unique => true
  end

  def self.down
    remove_index :actors, :email
    remove_index :actors, :permalink
    remove_index :users, :confirmation_token
    remove_index :users, :reset_password_token

    rename_column :users, :encrypted_password, :password
    remove_column :users, :password_salt
    remove_column :users, :confirmation_token
    remove_column :users, :confirmed_at
    remove_column :users, :confirmation_sent_at
    remove_column :users, :reset_password_token
  end
end
