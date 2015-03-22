class UserPoke < ActiveRecord::Base
  self.table_name = "user_pokes"
  
  belongs_to :user
  belongs_to :poke


end
