class UserPoke < ActiveRecord::Base
  self.table_name = "user_pokes"

  belongs_to :user
  belongs_to :poke

  validates :ev, numericality: { greater_than_or_equal_to: 1,
    less_than_or_equal_to: 510,
    only_integer: true }
  validates :level, numericality: { greater_than_or_equal_to: 1,
    less_than_or_equal_to: 100,
    only_integer: true }

  def self.validate?(params)
    if (params["ev"].to_i < 0 or params["ev"].to_i > 510) then return false end
    if (params["level"].to_i < 1 or params["level"].to_i > 100) then return false end
    return true
  end

  def self.find_by_poke_and_user user_id, poke_id
    ActiveRecord::Base.connection.execute("SELECT * FROM user_pokes WHERE user_id=#{user_id} AND poke_id=#{poke_id}").first['user_poke_id']
  end

  def self.find_by_id(id)
    Poke.find_by_sql("SELECT * FROM user_pokes WHERE user_poke_id = '#{id}'").first
  end

  def self.destroy(id)
    Poke.find_by_sql("")
  end

end
