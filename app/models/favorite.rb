class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :uma
  validates_uniqueness_of :uma_id, scope: :user_id

  def favorite_user(user)
    Favorite.where(user_id: user)
  end
end
