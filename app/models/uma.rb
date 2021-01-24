require 'mechanize'

class Uma < ApplicationRecord
  validates :name, {presence: true, uniqueness: true}
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites

  def self.search(search)
      return Uma.all() unless search
      Uma.where('title LIKE(?)', "%#{search}%")
  end
end

  #   @uma = Uma.all
  #   @favorite = Favorite.where(user_id:user)
  #   @favorite_uma = []
  #   @favorite.each do |f|
  #     hash = Hash.new{|h,k| h[k] = uu }
  #       if @uma.find {|u| u.id == f.uma_id}
  #         u = Uma.find_by(id:f.uma_id)
  #         id = f.uma_id
  #         hash[:id] = id
  #         hash.store(:name,u.name)
  #         hash.store(:speed,f.speed)
  #         hash.store(:power,f.power)
  #       end
  #       @favorite_uma << hash
  #    end
  #   @favorite_uma = Kaminari.paginate_array(@favorite_uma).page(params[:page]).per(30)
  # end


