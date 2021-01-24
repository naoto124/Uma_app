require 'mechanize'

class Race < ApplicationRecord
  validates :code, {presence: true, uniqueness: true}

end