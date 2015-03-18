class AddPasswordDigestToUser < ActiveRecord::Migration
  def change
    execute "ALTER TABLE users ADD COLUMN password_digest varchar(255)"
  end
end
