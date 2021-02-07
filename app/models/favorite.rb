class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :uma
  validates_uniqueness_of :uma_id, scope: :user_id

  def favorite_user(user)
    Favorite.where(user_id: user)
  end

  def self.uma_find(parameter)
     Uma.find_by(id:parameter)
  end

  def self.favorite_create(parameter,user)
    @uma = self.uma_find(parameter)
    Favorite.create(user_id: user,uma_id:@uma.id)
  end

  def self.find_favorite(user,uma)
    Favorite.find_by(user_id: user,uma_id:uma)
  end
end
