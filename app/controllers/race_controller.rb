require 'mechanize'
require "date"
require 'active_support/all'


class RaceController < ApplicationController

  # elements = page.search('/html/body/div[2]/div[4]/div/div[1]/div[2]/table/tr[2]/td[1]/p[1]/a')

  # @race_n = []
  #   @race_n_a = []
  #   elements.each do |e|
  #     @race_n << e.inner_text
  #     if e.get_attribute('href').include?('race_21')
  #       @race_n_a << e.get_attribute('href')[27..42].to_s
  #     elsif r.get_attribute('href').include?('race_8')
  #       @race_n_a << e.get_attribute('href')[26..41].to_s
  #     end
  #   end
  #     @race_name_a = @race_name_a.uniq


  # 実行用
  def next_race(d)
    agent = Mechanize.new()
      @page_5 = 'https://umanity.jp/racedata/race_5.php?date='
      this_day(@page_5 + (d))

      next_day(@page_5 + (d))
  end
  def judge(j)
    agent = Mechanize.new()
      page_8 = 'https://umanity.jp/racedata/race_8.php?code=' + (j)
      page = agent.get(page_8)
      @a = page.search('/html/body/div[2]/div[4]/div/div/table[1]/tr/td[1]/table[2]/tr[2]/td/div/div[1]/div[3]').empty?
      p page.search('/html/body/div[2]/div[4]/div/div/table[1]/tbody/tr/td[1]/table[2]/tbody/tr[2]/td/div/div[1]/div[3]')
      p @a
  end

  def show_race(sh)
    agent = Mechanize.new()
    @page_7 = 'https://umanity.jp/racedata/race_7.php?code='
      race_title(@page_7 + (sh))
      race_specil(@page_7 + (sh))
  end

  def run_race(ru)
    agent = Mechanize.new()
    @page_8 = 'https://umanity.jp/racedata/race_8.php?code='
      race_title(@page_8 + (ru))
      race_uma(@page_8 + (ru))
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
    # show_race(@race.code)
    p "kkkkkk"
    # p judge(params[:name].to_s)
    if judge(params[:name].to_s) == false
      run_race(params[:name].to_s)
    elsif judge(params[:name].to_s) == true
      redirect_to action: :show
      return
    else redirect_to action: :info and return
    end
    # p run_race(params[:name].to_s)


    if Race.find_by(code: params[:name]) == nil
      race = Race.new
      race.code = params[:name]
      race.name = @race_title
      race.save ? (redirect_to request.referer) : (render :race_info_path) and return
    end
    p "------"
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
      @race_nums = page.search('td.td_racenum a')
      @race_names = page.search('td.td_racename a')

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
      end

      @place_num.each do |pln|
        @place << pln.slice(0..1)
      end

      @num = @num.uniq
      @place = @place.uniq

      @race_names.each do |r|
        @race_name << r.inner_text
        if r.get_attribute('href').include?('race_21')
          @race_name_a << r.get_attribute('href')[27..42].to_s
        elsif r.get_attribute('href').include?('race_8')
          @race_name_a << r.get_attribute('href')[26..41].to_s
        end
      end
      @race_name_a = @race_name_a.uniq
      p "ooooo"
      p @place[0]

    if @race_name[0] == nil
      @race_ple = page.search('th.th_place')
      @race_nums = page.search('th.th_racenum')
      @race_names = page.search('a.race_name')
      @race_name = []
      @race_name_a = []
      @ple = [] 

      @race_days_info = []
      @race_nums.each do |r|
        n = r.inner_text
        hash = Hash.new{|h,k| h[k] = n}
        hash[:n] = n
        @race_days_info << hash
        # p r
      end
      # p @race_days_info
      @race_ple.each do |r|
        @ple << r.inner_text
      end
      # p @ple

      @race_names.each_with_index do |r,i|
        # p r.inner_text
        @race_days_info[i].store(:race_name,r.inner_text)

        if r.get_attribute('href').include?('race_21')
        @race_days_info[i].store(:race_name_a,r.get_attribute('href')[27..42].to_s)
        elsif r.get_attribute('href').include?('race_8')
          @race_days_info[i].store(:race_name_a,r.get_attribute('href')[26..41].to_s)
        end
      end
      p @race_days_info
    end


  end


  def race_title(ra)
    agent = Mechanize.new()
    page = agent.get(ra)
    # レースtitle
    elements = page.search('div.detail div')
    elements_h = page.at('div.detail h2')
    @race_title = elements_h.inner_text
    @race_title_info = []
      elements .each do |ele|
        @race_title_info << ele.inner_text.to_s
      end
      # p race_title
    # @race_title.slice!(2,2)
  end

  def race_specil(r)
    agent = Mechanize.new()
    page = agent.get(r)

    if page
    # レース中身
      @race_text = []
      @race_uma_code = []
      elements = page.search('div.race tbody td a')
      @race_text = []
      @race_uma_code = []

      elements = page.search('div.race tbody td a')
      elements.each do |ele|
        if Uma.find_by(code: ele.get_attribute('href')[44..53].to_s == nil)
          uma = Uma.new
          uma.code = ele.get_attribute('href')[44..53].to_s
          uma.name = ele.inner_text
          uma.save ? (redirect_to request.referer) : (render :show)
        end
        if ele.get_attribute('href').include?('//umanity.jp/racedata/db/horse_top.php?code=')
          @race_text << ele.inner_text
          @race_uma_code << ele.get_attribute('href')[44..53].to_s
        end

      end

      @race_text = @race_text
      @race_uma_code = @race_uma_code
    end

  end

  def race_uma(ue)
    agent = Mechanize.new()
    page = agent.get(ue)
    if page
      race_f = page.iframe_with(name: 'racecard').click

      elements = race_f.search ('/html/body/div/form/table/tr/td/table/tr/td[5]/table/tr/td')

      box = race_f.search ('/html/body/div/form/table/tr/td/table/tr/td[1]')
      box.shift
      uma_number = race_f.search ('/html/body/div/form/table/tr/td/table/tr/td[2]')
      sex_age = race_f.search ('/html/body/div/form/table/tr/td/table/tr/td[6]/span')
      weight = race_f.search ('/html/body/div/form/table/tr/td/table/tr/td[7]')
      jokey = race_f.search ('/html/body/div/form/table/tr/td/table/tr/td[8]/a')
      popular = race_f.search ('/html/body/div/form/table/tr/td/table/tr/td[11]')

      @uma_info = []
      elements.each do |ele|
        e = ele.children
        hash = Hash.new{|h,k| h[k] = uu }
        if e.inner_text.present? && e[0].get_attribute("href") != nil
          uma = e.inner_text
          hash[:uma_name] = uma
          hash.store(:uma_code,e[0].get_attribute("href")[44..53])
        elsif e.inner_text.present? && e[0].get_attribute("href") == nil
          ec = e.children
          uma = ec.inner_text
          hash[:uma_name] = uma
          hash.store(:uma_code,ec[0].get_attribute("href")[44..53])
        else next
        end
        if Uma.find_by(code: hash[:uma_code]) == nil
          uma = Uma.new
          uma.code = hash[:uma_code]
          uma.name = hash[:uma_name]
          uma.save ? (redirect_to request.referer) : (render :show)
          return
        end
        @uma_info << hash
      end


      disassembly(box,:box)
      disassembly(uma_number,:uma_number)
      disassembly(sex_age,:sex_age)
      disassembly(weight,:weight)
      disassembly(jokey,:jokey)
      disassembly(popular,:popular)

      @uma_info.each do |u|
        u_a = Uma.find_by(name: u[:uma_name])
        if u_a != nil
          u.store(:uma_id,u_a.id)
        end
      end
      # p @uma_info[0][:uma_id]
      @favorite = Favorite.where(user_id: current_user.id)
      # p "pppppp"
      # p @favorite[0].uma_id
    end
  end

  def disassembly(di,dd)
    (di).each_with_index do |d,i|
      @uma_info[i].store((dd),d.inner_text)
    end
  end




end