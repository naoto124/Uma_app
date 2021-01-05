require 'mechanize'

class Uma < ApplicationRecord
  validates :name, {presence: true, uniqueness: true}
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites


end
