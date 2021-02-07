require 'mechanize'

class Race < ApplicationRecord
  validates :code, {presence: true, uniqueness: true}
  # has_many :myraces, dependent: :destroy
  # has_many :users, through: :myraces
  # accepts_nested_attributes_for :myraces


  def self.race_code_nil?(name)
    if !Race.find_by(code: name)
      r = Race.find_by(code: name)
      r.code = name
      r.save ? (redirect_to request.referer) : (render :show)
    end
  end

  def self.race_find_code(name)
    Race.find_by(code: name)
  end

  def race_find_id(id)
    Race.find_by(id: id)
  end

end