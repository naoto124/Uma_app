require 'mechanize'

class Race < ApplicationRecord
  validates :code, {presence: true, uniqueness: true}

  def self.race_code_nil?(name)
    if !Race.find_by(code: name)
      r = Race.find_by(code: name)
      r.code = name
      r.save ? (redirect_to request.referer) : (render :show)
    end
  end
end