require 'mechanize'
require "date"
require 'active_support/all'


class RaceController < ApplicationController

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
      @a = page.search('/html/body/div[2]/div[4]/div/div/table[2]/tr/td[1]/table/tr/td[2]/h3/a').empty?
      p page.search('/html/body/div[2]/div[4]/div/div/table[2]/tr/td[1]/table/tr/td[2]/h3/a').empty?
      p @a
  end

  def judge_result(ju)
    agent = Mechanize.new()
      page_21 = 'https://umanity.jp/racedata/race_21.php?code=' + (ju)
      page = agent.get(page_21)
      @a = page.search('/html/body/div[2]/div[4]/div/div/table[2]/tr/td[1]/table/tr/td[4]/h3/a').empty?
      # p page.search('/html/body/div[2]/div[4]/div/div/table[2]/tr/td[1]/table/tr/td[4]/h3/a').empty?
      # p @a
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

  def run_result(mo)
    agent = Mechanize.new()
    @page_21 = 'https://umanity.jp/racedata/race_21.php?code='
      race_title(@page_21 + (mo))
      race_result(@page_21 + (mo))
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
    @code = params[:name]
    if Race.find_by(code: params[:name]) == nil
      race = Race.new
      race.code = params[:name]
      race.name = @race_title
      race.save ? (redirect_to request.referer) : (render :race_info_path) and return
    end
    p "kkkkkk"
    # if judge_result(params[:name].to_s) == true
      if judge(params[:name].to_s) == false
        run_race(params[:name].to_s)
        return
      elsif judge(params[:name].to_s) == true
        redirect_to action: :show
        return
      elsif judge_result(params[:name].to_s) == false
        redirect_to action: :result
        return
      else redirect_to action: :info and return
    end
    # p run_race(params[:name].to_s)

    # renderが２つ発生する処理が走るとエラーが起こるかも

    p "------"
  end

  def result
    @code = params[:name]
    run_result(params[:name].to_s)
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
      end
      p "eee"
      p @race_days_info[0]
      @race_ple.each do |r|
        @ple << r.inner_text
      end
      # p @ple

      c = 0
      @race_days_info.each_with_index do |r,i|
          # p r.inner_text
        if r[:n].empty?
          @race_days_info[i].store(:race_name,"-----")
          @race_days_info[i].store(:race_name_a,"-----")
        else
          inner = @race_names[c].inner_text
          p "rrrrrr"
          p inner
          @race_days_info[i].store(:race_name,inner)
          a = @race_names[c].get_attribute('href')
          p "wwww"
          p a
          if a.include?('race_21')
          @race_days_info[i].store(:race_name_a,a[27..42].to_s)
          elsif a.include?('race_8')
            @race_days_info[i].store(:race_name_a,a[26..41].to_s)
          elsif a == nil
            next
          end
          c += 1
        end
      end
      p "qqqqqq"
      p @race_days_info
      @r = @race_days_info.each_slice(@ple.count).to_a
    end


  end


  def race_title(ra)
    agent = Mechanize.new()
    page = agent.get(ra)
    # レースtitle
    elements = page.search('div.detail div')
    elements_h = page.at('div.detail h2')
    elements_p = page.at('tr.table-cell a.select')
    @race_title = elements_h.inner_text
    @race_title_info = []
      elements .each do |ele|
        @race_title_info << ele.inner_text.to_s
      end
      @plece = elements_p.inner_text
    t = @race_title_info[0].slice('芝') || ('ダート')
    d = @race_title_info[0].split
    d = d[1].delete('m')

      @couse = Couse.find_by(place: @plece, stage: t, distance: d)
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
    p "ggggg"
    p params
    if !Race.find_by(code:params[:name])
      r = Race.find_by(code:params[:name])
      r.code = params[:name]
      r.save ? (redirect_to request.referer) : (render :show)
    end

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
          @uma_info << hash
      end



      disassembly(box,:box)
      disassembly(uma_number,:uma_number)
      disassembly(sex_age,:sex_age)
      disassembly(weight,:weight)
      disassembly(jokey,:jokey)
      disassembly(popular,:popular)

      @uma_info.each_with_index do |u,i|
        u_a = Uma.find_by(code: u[:uma_code])
        if u_a != nil
          u.store(:uma_id,u_a.id)
        elsif u_a == nil
          uma = Uma.new
          uma.name = u[:uma_name]
          uma.code = u[:uma_code]
          uma.save
        redo
        else redirect_to root_path
        end
      end

      # p @uma_info[0][:uma_id]
      @favorite = Favorite.where(user_id: current_user.id)
      @couse_parameter = CouseParameter.where(user_id: current_user.id)
      # p "pppppp"
      # p @favorite[0].uma_id
    end
  end

  def disassembly(di,dd)
    (di).each_with_index do |d,i|
      @uma_info[i].store((dd),d.inner_text)
    end
  end

      def race_result(me)
      agent = Mechanize.new()
      page = agent.get(me)

      @race_all = page.search('/html/body/div[2]/div[4]/div/div/table[3]/tr/td/div/div/table[1]/tr/td/table/tr/td/table/tr/td').each_slice(19).to_a

      # all = ["rank","box","number",:uma_name,"sex_age","weight","jokey","g","ozz","poplar","time","space","f3","middle"]
      @raceall = []
      @race_all.each_with_index do |al,m|
        al.each_with_index do |a,i|
            if  i == 3
              p "eeee"
              p a.inner_text.gsub(/\s/, '')
              if Uma.find_by(code:a.children.children.children.children.at_css('a')[:href][44..53]) == nil
                u = Uma.new
                u.name = a.inner_text.gsub(/\s/, '')
                u.code = a.children.children.children.children.at_css('a')[:href][44..53]
                u.save ? (redirect_to request.referer) : (render :show)
                return
              end
              p "eeee"
              hash = Hash.new{|h,k| h[k] = n}
              hash[:uma_name] = a.inner_text.gsub(/\s/, '')
              hash[:uma_name_a] = a.children.children.children.children.at_css('a')[:href][44..53]
              @raceall << hash
            end
          end
        end

      @race_all.each_with_index do |al,m|
        al.each_with_index do |a,i|
          case
          when i == 0
          @raceall[m].store(:rank, a.inner_text)
          when i == 1
          @raceall[m].store(:box, a.inner_text)
          when i == 2
          @raceall[m].store(:number, a.inner_text)
          when i == 4
          @raceall[m].store(:sex_age, a.inner_text)
          when i == 5
          @raceall[m].store(:weight, a.inner_text)
          when i == 6
          @raceall[m].store(:jokey, a.inner_text)
          when i == 9
          @raceall[m].store(:g, a.inner_text)
          when i == 10
          @raceall[m].store(:ozz, a.inner_text)
          when i == 11
          @raceall[m].store(:popular, a.inner_text)
          when i == 13
          @raceall[m].store(:time, a.inner_text)
          when i == 14
          @raceall[m].store(:space, a.inner_text)
          when i == 15
          @raceall[m].store(:f3, a.inner_text)
          when i == 16
          @raceall[m].store(:middle, a.inner_text)
          else next
          end
        end
      end

      @raceall.each do |u|
        u_a = Uma.find_by(name: u[:uma_name])
        if u_a != nil
          u.store(:uma_id,u_a.id)
        end
      end

      @favorite = Favorite.where(user_id: current_user.id)
      @couse_parameter = CouseParameter.where(user_id: current_user.id)
      # p "----------------"
      # p "----------------"
      # p @favorite[0]
      # p @raceall[0][:uma_id]
      # p "----------------"

    end

end