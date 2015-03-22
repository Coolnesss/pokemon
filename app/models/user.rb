class User < ActiveRecord::Base
  self.table_name = "users"

  has_many :user_pokes


  validates :username, uniqueness: true,
  length: { minimum: 3 }

  has_secure_password

  def has_poke_in_list? poke
    not ActiveRecord::Base.connection.execute("SELECT * FROM user_pokes WHERE user_id = #{self.user_id} AND poke_id = #{poke.poke_id} ").first.nil?
  end

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
