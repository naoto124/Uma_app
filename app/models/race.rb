require 'mechanize'

class Race < ApplicationRecord
  validates :code, {presence: true, uniqueness: true}

  def self.get_race(te)
    agent = Mechanize.new
    page = agent.get(te)

    elements_a = page.search('table.racedata_race_chart_table td a')
    
    elements_a.each do |element|
      if element.get_attribute('href').include?('//umanity.jp/racedata/race_21.php?code')
        race = Race.new
        race.code = element.get_attribute('href').to_s
        race.code = race.code[39..55].to_s
        race.save
      end
    end
  end

  def self.uma_race_link
    agent = Mechanize.new

    codes = Uma.pluck(:code)


    codes.each do |code|
      get_race("https://umanity.jp/racedata/db/horse_top.php?code=" + code.to_s)
    end


  end


  def self.race_parts
    agent = Mechanize.new
    
    code = Race.pluck(:code)
    code.each do |c|
      if c != nil
        @c = c
        race_link("https://umanity.jp/racedata/race_21.php?code=" + @c)
      end
    end


  end

  def self.race_link(te)
    agent = Mechanize.new   
    page = agent.get(te)
    elements = page.search('h2.racecard')
    elements.each do |element|
      if element.inner_text.split.length < 3
        race = Race.find_by(code: @c)
          race.name = element.inner_text.split[1]
          race.save
      elsif 
        race = Race.find_by(code: @c)
            race.name = element.inner_text.split[2]
            race.save

      end
    end
    
  end


end