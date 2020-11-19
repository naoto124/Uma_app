require 'mechanize'
require "date"

class RaceController < ApplicationController

  def this_day(page_u)
    agent = Mechanize.new()
    page = agent.get(page_u)
    element = page.at('li.select')
    @now = element.inner_text.to_s
  end

  def next_day(page)
    agent = Mechanize.new()
    page = agent.get(page)

    elements = page.search('ul.clearfix li a')
    elements.each do |e|
      if Date.parse(e.get_attribute('href').to_s[6..15]) >= Date.today
      @next << e.inner_text
      @url << e.get_attribute('href')[6..15].to_s
      end
    end
  end

  def next_race
    agent = Mechanize.new
    n = Date.today

      tY = n.year
      tM = n.month
      tD = n.day
      da = "#{tY}/#{tM}/#{tD}"
      
      this_day('https://umanity.jp/racedata/race_5.php?date=' + da)

      next_day('https://umanity.jp/racedata/race_5.php?date=' + da)
  end

  # def race5
  #   agent = Mechanize.new
  #   now = Date.today
  #   now_week = []
  #   for i in 0..3 do
  #     now_week << now + i
  #   end

  #   now_week.each do |n|
  #     tY = n.year
  #     tM = n.month
  #     tD = n.day
  #     da = "#{tY}/#{tM}/#{tD}"
  #     if page('https://umanity.jp/racedata/race_5.php?date=' + da) == nil
  #       next
  #       end
  #     end
  # end


  def index
    @next = []
    @url = []
   next_race()
  end

  def info
    @dey_code = params[:name]
    agent = Mechanize.new()
    page = agent.get('https://umanity.jp/racedata/race_5.php?date=' + @dey_code)
    elements = page.search('race_list_table_type01 p')
    @e
    elements.each do |element|
      @e << element.inner_text
    end

  end

  def show
    p params[:name]
    @race = Race.find_by(code: params[:name])
  end
end
