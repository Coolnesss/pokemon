class RollbackBadApiidAndAddNew < ActiveRecord::Migration
  def change
    execute "ALTER TABLE user_pokes DROP COLUMN api_id"
    execute "ALTER TABLE pokes ADD COLUMN api_id INT"
  end
end
