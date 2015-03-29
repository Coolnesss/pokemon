# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

for i in 1..151
  info = JSON.parse(Pokegem.get("pokemon", i))
  name = info['name']
  if (Poke.find_by name:nam).nil? then Poke.create(name:name, api_id:i) end
end
