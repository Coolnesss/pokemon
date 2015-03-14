class User < ActiveRecord::Base
  self.table_name = "users"

  def self.sqlAll
    ActiveRecord::Base.connection.execute("SELECT * FROM users").to_a
  end

  def self.find_by_username username
    ActiveRecord::Base.connection.execute("SELECT * FROM users WHERE username = '#{username}'").first
    #User.sqlAll.each{|z| z['username'] == username }.first
  end
end
