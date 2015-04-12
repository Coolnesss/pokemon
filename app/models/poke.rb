class Poke < ActiveRecord::Base
  self.table_name = "pokes"

  has_many :user_pokes

  validates :name,
    uniqueness: true,
    length: { in: 3..11 } #Longest Pokemon name is Fletchinder


  def validate(name)
    Pokegem.get("pokemon", name).empty?
  end

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
