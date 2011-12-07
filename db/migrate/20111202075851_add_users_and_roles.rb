class AddUsersAndRoles < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :nick
      t.string :email, :null => false
      t.string :crypted_password, :null => false
      t.string :password_salt, :null => false
      t.string :persistence_token, :null => false
      t.integer :users, :role_id

      t.timestamps
    end

    create_table :roles do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :users
    drop_table :roles
  end
end
