class CreatePokemonsTable < ActiveRecord::Migration
  def change
    execute "CREATE TABLE pokes(
    poke_id serial PRIMARY KEY,
    name VARCHAR (50) UNIQUE NOT NULL
    );"
  end
end
