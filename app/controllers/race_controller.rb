require 'mechanize'
require "date"

class RaceController < ApplicationController

  # 実行用
  def next_race(d)
    agent = Mechanize.new()
      
      this_day('https://umanity.jp/racedata/race_5.php?date=' + (d))

      next_day('https://umanity.jp/racedata/race_5.php?date=' + (d))
  end

  def show_race(sh)
    agent = Mechanize.new()
      race_title('https://umanity.jp/racedata/race_7.php?code=' + (sh))
      race_specil('https://umanity.jp/racedata/race_7.php?code=' + (sh))
  end

  def run_race(ru)
    agent = Mechanize.new()
      race_title('https://umanity.jp/racedata/race_8.php?code=' + (ru))
      race_main('https://umanity.jp/racedata/race_8.php?code=' + (ru))
  end

  # メインaction

  def index
    n = Date.today
    tY = n.year
    tM = n.month
    tD = n.day
    da = "#{tY}/#{tM}/#{tD}"
    p da
    @next = []
    @url = []
   next_race(da)
  end

  def create
    
  end


  def info
    # @dey_code = params[:name]
    @next = []
    @url = []
    next_race(params[:name].to_s)
  end


  def show
    p params[:name]
    @code = params[:name]
    @race = Race.find_by(code: params[:name])
    p "------"
    p @race
    # show_race(@race.code)
    show_race(params[:name].to_s)
  end

  def run
    p params[:name]
    @race = Race.find_by(code: params[:name])
    p "------"
    p @race
    # show_race(@race.code)
    run_race(params[:name].to_s)

  end

  # 処理メソッド

  def this_day(page_u)
    agent = Mechanize.new()
    page = agent.get(page_u)
    element = page.at('li.select')
    @now = element.inner_text.to_s
  end

  def next_day(page)
    agent = Mechanize.new()
    page = agent.get(page)

    # レース日のリンク
    elements = page.search('ul.clearfix li a')
    elements.each do |e|
      @next << e.inner_text
      @url << e.get_attribute('href')[6..15].to_s
    end

    # レース日のレース
    # if page.search('td.td_racenum a')
      @race_nums = page.search('td.td_racenum a')
      @race_names = page.search('td.td_racename a')
    # else
    #   @race_nums = page.search('th.th_racenum a')
    #   @race_names = page.search('a.race_name')

    # end

      @race_name = []
      @race_name_a = []
      @place_num = []

      @race_nums.each do |r|
        @place_num << r.inner_text
      end

      @num = []
      @place = []

      @place_num.each do |pln|
        @num << pln.slice(2..4)
        # p pln.slice(2..4)
      end

      @place_num.each do |pln|
        @place << pln.slice(0..1)
        # p pln.slice(0..1)
      end

      @num = @num.uniq
      @place = @place.uniq
      p @place.count

      @race_names.each do |r|
        @race_name << r.inner_text
        @race_name_a << r.get_attribute('href')[27..42].to_s
      end
      @race_name_a = @race_name_a.uniq
      p @race_name_a[0]
  

  end

  def race_title(ra)
    agent = Mechanize.new()
    page = agent.get(ra)
    # レースtitle
    elements = page.search('td.ttl div')
    @race_title = []
      elements.each do |ele|
        @race_title << ele.inner_text.to_s
      end
    @race_title.slice!(2,2)
  end

  def race_specil(r)
    agent = Mechanize.new()
    page = agent.get(r)

    # レース中身
    @race_text = []
    @race_uma_code = []
    elements = page.search('div.race tbody td a')
    @race_text = []
    @race_uma_code = []

    elements = page.search('div.race tbody td a')
    elements.each do |ele|
      if ele.get_attribute('href').include?('//umanity.jp/racedata/db/horse_top.php?code=')
      @race_text << ele.inner_text
      @race_uma_code << ele.get_attribute('href')[44..53].to_s
      end
    end

    @race_text = @race_text
    @race_uma_code = @race_uma_code


  end

  def race_main(race)
    agent = Mechanize.new()
    page = agent.get(race)
    # レース中身
    # タイトル
    race_f = page.iframe_with(name: 'racecard').click
    race_heads = race_f.search('th.table-title')

    @race_head = []
    race_heads.each do |head|
      @race_head << head.inner_text
    end
    @race_head.slice!(2,2)
    @race_head.slice!(3)
    @race_head.slice!(8,10)
    @race_head.slice!(5)
    @race_head.slice!(5)
    @race_head.slice!(3)
    @race_head.slice!(5)
    @race_head.slice!(4)
    @race_head.slice!(0..1)

    # @race_head


    race_odd = race_f.search('tr.odd-row td')
    race_even = race_f.search('tr.even-row td')

    @jokey = []
    race_f.search('tr.table-frame td a').each do |j|
      if j[:href].include?('umanity.jp/racedata/database_jockey_1.php?code=')
        @jokey << j.inner_text
      end
    end
    p @jokey

    @race_a = []

    race_f.links_with(:href => /horse_top/).each do |link|
      @race_a << link.href[44..53]
    end

    @uma = []
    @race_a.each do |a|
      if Uma.find_by(code:a) != nil
        @uma << Uma.find_by(code:a)
      end
    end

    p @race_a
    p @uma
    @odd = []
    @even = []

    # @main = []

    # slices(race_odd,@odd)
    # slices(race_even,@even)
    # @odd.zip(@even) do |o,e|
    #   @main << o
    #   @main << e
    # end

    # p @main

  end

  # def slices(oe,ooee)
  #   oeoe = []
  #   oe.each do |m|
  #     if nil != (m.inner_text =~ /\A[0-9]+\z/) && m == nil
  #      oeoe << m.inner_text
  #     end
  #   end

  # end


end