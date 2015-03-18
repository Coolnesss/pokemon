class User < ActiveRecord::Base
  self.table_name = "users"

  validates :username, uniqueness: true,
  length: { minimum: 3 }

  has_secure_password

  def self.sqlAll
    ActiveRecord::Base.connection.execute("SELECT * FROM users").to_a
  end

  def self.find_by_username username
    ActiveRecord::Base.connection.execute("SELECT * FROM users WHERE username = '#{username}'").first
    #User.sqlAll.each{|z| z['username'] == username }.first
  end

  def self.find_by_id(id)
    User.find_by_sql("SELECT * FROM users WHERE user_id = '#{id}'").first
  end
end
