module RaceHelper

  def mechanize_page(page_url)
      agent = Mechanize.new()
      page_url
  end

  def mechanize_page_get(page_url)
      agent = Mechanize.new()
      page = agent.get(page_url)
  end

    # 実行用
  def next_race(d)
     @page_5 = mechanize_page('https://umanity.jp/racedata/race_5.php?date=')
      this_day(@page_5 + (d))

      next_day(@page_5 + (d))
  end

  def judge(j)
      page = mechanize_page_get('https://umanity.jp/racedata/race_8.php?code=' + (j))
      # page = agent.get(page_8)
      @b = page.search('/html/body/div[2]/div[4]/div/div/table[2]/tr/td[1]/table/tr/td[2]/h3/a').empty?
  end

  def judge_result(ju)
      page = mechanize_page_get('https://umanity.jp/racedata/race_21.php?code=' + (ju))
      a = page.search('/html/body/div[2]/div[4]/div/div/table[2]/tr/td[1]/table/tr/td[4]/h3/a').empty?
  end

  def show_race(sh)
    @page_7 = mechanize_page('https://umanity.jp/racedata/race_7.php?code=')
      race_title(@page_7 + (sh))
      race_specil(@page_7 + (sh))
  end

  def run_race(ru)
    @page_8 = mechanize_page('https://umanity.jp/racedata/race_8.php?code=')
      race_title(@page_8 + (ru))
      race_uma(@page_8 + (ru))
  end

  def run_result(mo)
    @page_21 = mechanize_page('https://umanity.jp/racedata/race_21.php?code=')
      race_title(@page_21 + (mo))
      race_result(@page_21 + (mo))
  end

    # 処理メソッド

  def this_day(page_u)
    page = mechanize_page_get(page_u)
    element = page.at('li.select')
    @now = element.inner_text.to_s
  end

  def next_day(page)
    page = mechanize_page_get(page)

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
      @race_ple.each do |r|
        @ple << r.inner_text
      end

      c = 0
      @race_days_info.each_with_index do |r,i|
        if r[:n].empty?
          @race_days_info[i].store(:race_name,"-----")
          @race_days_info[i].store(:race_name_a,"-----")
        else
          inner = @race_names[c].inner_text
          @race_days_info[i].store(:race_name,inner)
          a = @race_names[c].get_attribute('href')
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
      @r = @race_days_info.each_slice(@ple.count).to_a
    end


  end


  def race_title(ra)
    page = mechanize_page_get(ra)
    # レースtitle
    elements = page.search('div.detail div')
    elements_h = page.at('div.detail h2')
    elements_p = page.at('tr.table-cell a.select')
    @race_title = elements_h.inner_text
    @race_title_info = []
      elements .each do |ele|
        @race_title_info << ele.inner_text.to_s
      end
      @place = elements_p.inner_text
    t = @race_title_info[0].slice('芝') || ('ダート')
    d = @race_title_info[0].split
    d = d[1].delete('m')

      c = Couse.new
      @couse = c.couse_pltd(@place,t,d)
  end

  def race_specil(r)
    page = mechanize_page_get(r)

    if page
    # レース中身
    elements = page.search('div.race tbody td a')
      @race_text = []
      @race_uma_code = []

      u = Uma.new
      u.uma_new_save?(elements,@race_text,@race_uma_code)
    end

  end

  def race_uma(ue)
    page = mechanize_page_get(ue)
    params_name = params[:name]
    Race.race_code_nil?(params_name)

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

      @racealls = []
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
          @racealls << hash
      end

      disassembly(box,:box)
      disassembly(uma_number,:uma_number)
      disassembly(sex_age,:sex_age)
      disassembly(weight,:weight)
      disassembly(jokey,:jokey)
      disassembly(popular,:popular)

      @racealls.each_with_index do |u,i|
        u_c = Uma.new
        u_a = u_c.uma_find_code(u[:uma_code])
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
      f = Favorite.new
      c_p = CouseParameter.new
      @favorite = f.favorite_user(current_user.id)
      @couse_parameter = c_p.couse_parameter_user(current_user.id)
    end
  end

  def disassembly(di,dd)
    (di).each_with_index do |d,i|
      @racealls[i].store((dd),d.inner_text)
    end
  end

  def race_result(me)
    page = mechanize_page_get(me)

    @race_all = page.search('/html/body/div[2]/div[4]/div/div/table[3]/tr/td/div/div/table[1]/tr/td/table/tr/td/table/tr/td').each_slice(19).to_a

    @racealls = []
    @race_all.each_with_index do |al,m|
      al.each_with_index do |a,i|
          if  i == 3
            p "eeee"
            hash = Hash.new{|h,k| h[k] = n}
            hash[:uma_name] = a.inner_text.gsub(/\s/, '')
            hash[:uma_name_a] = a.children.children.children.children.at_css('a')[:href][44..53]
            @racealls << hash
          end
        end
      end

      @race_all.each_with_index do |al,m|
        al.each_with_index do |a,i|
          case
          when i == 0
          @racealls[m].store(:rank, a.inner_text)
          when i == 1
          @racealls[m].store(:box, a.inner_text)
          when i == 2
          @racealls[m].store(:number, a.inner_text)
          when i == 4
          @racealls[m].store(:sex_age, a.inner_text)
          when i == 5
          @racealls[m].store(:weight, a.inner_text)
          when i == 6
          @racealls[m].store(:jokey, a.inner_text)
          when i == 9
          @racealls[m].store(:g, a.inner_text)
          when i == 10
          @racealls[m].store(:ozz, a.inner_text)
          when i == 11
          @racealls[m].store(:popular, a.inner_text)
          when i == 13
          @racealls[m].store(:time, a.inner_text)
          when i == 14
          @racealls[m].store(:space, a.inner_text)
          when i == 15
          @racealls[m].store(:f3, a.inner_text)
          when i == 16
          @racealls[m].store(:middle, a.inner_text)
          else next
          end
        end
      end

      @racealls.each do |u|
        u_n = Uma.new
        u_a = u_n.uma_find_name(u[:uma_name])
        if u_a != nil
          u.store(:uma_id,u_a.id)
        end
      end

      f = Favorite.new
      c_p = CouseParameter.new
      @favorite = f.favorite_user(current_user.id)
      @couse_parameter = c_p.couse_parameter_user(current_user.id)

    end

end
