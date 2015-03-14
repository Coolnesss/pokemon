class Poke < ActiveRecord::Base

  def self.sqlAll
    Poke.find_by_sql "SELECT * FROM pokes"
  end

  def self.createPokemon(name)
    ActiveRecord::Base.connection.execute("INSERT INTO pokes (name) VALUES ('#{name}')")
  end

  def self.find_by_name(name)
    Poke.find_by_sql("SELECT * FROM pokes WHERE name = '#{name}'").first
  end

  def self.find_by_id(id)
    Poke.find_by_sql("SELECT * FROM pokes WHERE poke_id = '#{id}'").first
  end
end
