class User < ActiveRecord::Base
  self.table_name = "users"

  has_many :user_pokes

  validates :username, uniqueness: true,
  length: { minimum: 3 }

  has_secure_password

  def has_poke_in_list? poke
    @user_pokes ||= User.find_user_pokes(self.id)
    not UserPoke.find_by_sql(["SELECT * FROM user_pokes where user_id = ? AND poke_id = ?", self.id, poke.id]).empty?
  end

  def self.find_user_pokes(user_id)
    UserPoke.find_by_sql ["SELECT * FROM user_pokes WHERE user_id = ?", user_id]
  end

  def self.sqlAll
    ActiveRecord::Base.connection.execute("SELECT * FROM users").to_a
  end

  def self.find_by_username username
    User.find_by_sql(["SELECT * FROM users WHERE username = ?", username]).first
  end

  def self.find_by_id(id)
    User.find_by_sql(["SELECT * FROM users WHERE user_id = ?", id]).first
  end
end
