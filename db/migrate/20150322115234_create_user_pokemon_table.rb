class CreateUserPokemonTable < ActiveRecord::Migration
  def change
    execute "CREATE TABLE user_pokes(
    user_poke_id serial PRIMARY KEY,
    user_id INT references users(user_id),
    poke_id INT references pokes(poke_id)
    );"
  end
end
