class AddLevelToUserPoke < ActiveRecord::Migration
  def change
    execute "ALTER TABLE user_pokes ADD COLUMN level INT"
    execute "ALTER TABLE user_pokes ADD COLUMN ev INT"
  end
end
