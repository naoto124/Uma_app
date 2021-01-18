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
