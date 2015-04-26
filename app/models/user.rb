class User < ActiveRecord::Base
  self.table_name = "users"

  has_many :user_pokes

  validates :username, uniqueness: true,
  length: { minimum: 3 }

  def self.validate?(params)
    params["username"].length > 3 and params["password"] == params["password_confirmation"]
  end

  def self.authenticate(username, password)
    user = User.find_by_username(username)
    user && user.password == BCrypt::Engine.hash_secret(password, user.password_salt)
  end

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

  def destroySql
    UserPoke.find_by_sql(["DELETE FROM user_pokes WHERE user_id = ?", self.id])
    User.find_by_sql(["DELETE FROM users WHERE user_id = ?", self.id])
  end

  def self.createSql(params, password, password_salt)
    User.find_by_sql(["INSERT INTO users (username, password, password_salt) VALUES (?, ?, ?)", params["username"], password, password_salt])
  end

  def updateSql(password, password_salt)
    User.find_by_sql(["UPDATE users SET password = ?, password_salt = ? WHERE user_id = ?", password, password_salt, self.id])
  end
end
