class CreateUserTable < ActiveRecord::Migration
  def change
    execute "CREATE TABLE users(
    user_id serial PRIMARY KEY,
    username VARCHAR (50) UNIQUE NOT NULL
    );"
  end
end
