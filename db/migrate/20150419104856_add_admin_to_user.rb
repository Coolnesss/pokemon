class AddAdminToUser < ActiveRecord::Migration
  def change
    execute "ALTER TABLE users ADD COLUMN admin BOOLEAN DEFAULT FALSE;"
  end
end
