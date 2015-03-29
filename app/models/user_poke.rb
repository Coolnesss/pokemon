class UserPoke < ActiveRecord::Base
  self.table_name = "user_pokes"

  belongs_to :user
  belongs_to :poke

  def self.find_by_poke_and_user user_id, poke_id
    ActiveRecord::Base.connection.execute("SELECT * FROM user_pokes WHERE user_id=#{user_id} AND poke_id=#{poke_id}").first['user_poke_id']
  end

  def self.find_by_id(id)
    Poke.find_by_sql("SELECT * FROM user_pokes WHERE user_poke_id = '#{id}'").first
  end

end
