require 'mechanize'

class Race < ApplicationRecord
  validates :name, {presence: true}


  # def self.race_index_link
  #   agent = Mechanize.new

  #   years = (2015..2020).to_a
  #   turns = ("01".."10").to_a
  #   places = ("01".."10").to_a
  #   days = ("01".."10").to_a
  #   day_races = ("01".."12").to_a

  #   years.each do |y|
  #     turns.each do |t|
  #       places.each do |place|
  #         days.each do |day|
  #           day_races.each do |race|
  #             p get_race_name("https://p.keibabook.co.jp/cyuou/syutuba/" + y.to_s + t.to_s + place.to_s + day.to_s + race.to_s)
  #           end
  #         end
  #       end
  #     end
  #   end

  # end

  # def self.get_race_name(te)
  #   agent = Mechanize.new
  #   page = agent.get(te)

  #   element = page.at('div.h1block h1')
  #   race = Race.new
  #   race.name = element.inner_text
  #   if element.inner_text
  #     race.save
  #   elsif element.inner_text == nil
  #     return false
  #   end

  # end
end