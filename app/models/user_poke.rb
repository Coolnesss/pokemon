class UserPoke < ActiveRecord::Base
  self.table_name = "user_pokes"

  before_validation :default_values

  belongs_to :user
  belongs_to :poke

  validates :ev, numericality: { greater_than_or_equal_to: 1,
    less_than_or_equal_to: 510,
    only_integer: true }
  validates :level, numericality: { greater_than_or_equal_to: 1,
    less_than_or_equal_to: 100,
    only_integer: true }

    def default_values
      self.ev = 1 if self.ev.nil?
      self.level = 1 if self.level.nil?
    end

  def self.validate?(params)
    if (params["ev"].to_i < 0 or params["ev"].to_i > 510) then return false end
    if (params["level"].to_i < 1 or params["level"].to_i > 100) then return false end
    return true
  end

  def self.createSql(user_id, poke_id)
    ActiveRecord::Base.connection.execute("INSERT INTO user_pokes (user_id, poke_id) VALUES (#{user_id},#{poke_id})")
  end

  def updateSql(params)
    UserPoke.find_by_sql(["UPDATE user_pokes SET ev = ?, level = ?", params["ev"], params["level"]])
    #ActiveRecord::Base.connection.execute("UPDATE user_pokes SET ev = #{params["ev"]}, level = #{params["level"]}  WHERE user_poke_id = #{self.user_poke_id}")
  end

  def self.find_by_poke_and_user user_id, poke_id
    UserPoke.find_by_sql(["SELECT * FROM user_pokes WHERE user_id = ? AND poke_id = ? ", user_id, poke_id]).first
  end

  def self.find_by_id(id)
    UserPoke.find_by_sql ["SELECT * FROM user_pokes WHERE user_poke_id = ?", id]
  end

  def self.destroySql(id)
    Poke.find_by_sql("DELETE FROM user_pokes WHERE user_poke_id=#{id}")
  end

end
