# class Myrace < ApplicationRecord
#   belongs_to :user
#   belongs_to :race
#   validates_uniqueness_of :race_id, scope: :user_id

#   def myrace_user(user)
#     Myrace.where(user_id: user)
#   end

#   def self.race_find(parameter)
#      Race.find_by(id:parameter)
#   end

#   def self.myrace_create(parameter,user)
#     @race = self.race_find(parameter)
#     Myrace.create(user_id: user,race_id:@race.id,code:@race.code,)
#   end

#   def self.find_myrace(user,race)
#     Myrace.find_by(user_id: user,race_id:race)
#   end

# end
