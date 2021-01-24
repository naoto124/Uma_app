class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :uma
  validates_uniqueness_of :uma_id, scope: :user_id


end
