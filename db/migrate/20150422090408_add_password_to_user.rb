class AddPasswordToUser < ActiveRecord::Migration
  def change
    execute "ALTER TABLE users ADD COLUMN password varchar(64);"
    execute "ALTER TABLE users ADD COLUMN password_salt varchar(64);"
  end
end
