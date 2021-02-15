require 'mechanize'
require "date"
require 'active_support/all'

class Uma < ApplicationRecord
  validates :name, {presence: true, uniqueness: true}
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites

  def self.search(search)
      return Uma.all() unless search
      Uma.where('title LIKE(?)', "%#{search}%")
  end

  def uma_new_save?(elements,race_text,race_uma_code)

    elements.each do |ele|
      if Uma.find_by(code: ele.get_attribute('href')[44..53].to_s == nil)
        uma = Uma.new(code:ele.get_attribute('href')[44..53].to_s,name:ele.inner_text)
        uma.save ? (redirect_to request.referer) : (render :show)
      end
      if ele.get_attribute('href').include?('//umanity.jp/racedata/db/horse_top.php?code=')
        race_text << ele.inner_text
        race_uma_code << ele.get_attribute('href')[44..53].to_s
      end
  
    end
  end


  # race helperで使用
  def uma_find_code(code)
    Uma.find_by(code: code)
  end
  def uma_find_name(name)
    Uma.find_by(name: name)
  end
  def uma_find_id(id)
    Uma.find_by(id: id)
  end

  def self.where_like(name)
    Uma.where('name like ?',"#{name}%")
  end
  def self.find_name(name)
    Uma.find_by(name:name)
  end
  def self.favorite(user,uma)
    u = Uma.find_by(id:uma)
    u.favorites.find_by(user_id: user)
  end

end


