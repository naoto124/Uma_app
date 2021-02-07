module UmaHelper
  def race_title
    @race_title = [
      "開催日","競馬場","R","レース名","コース","馬場","頭数","枠番","馬番",
      "オッズ","人気","着順","性•歳","斤量","騎手","調教師","馬体重","タイム",
      "着差","上がり(3F)","通過","勝馬(2着馬)",
    ]
  end

    def my_favorite(user)
    f = Favorite.new
    @favorite = f.favorite_user(user)
    my_favorite_umas
  end

  def my_favorite_umas
    @uma = Uma.all
    @favorite_uma = []
    @favorite.each do |f|
      hash = Hash.new{|h,k| h[k] = uu }
        if @uma.find {|u| u.id == f.uma_id}
          u = Uma.find_by(id:f.uma_id)
          id = f.uma_id
          hash[:id] = id
          hash.store(:name,u.name)
          hash.store(:speed,f.speed)
          hash.store(:power,f.power)
        end
        @favorite_uma << hash
     end
    @favorite_uma = Kaminari.paginate_array(@favorite_uma).page(params[:page]).per(30)

  end


    def detail_item
    p params[:name]
    
    @uma = Uma.find_by(name: params[:name])
    
    @code = @uma.code

    agent = Mechanize.new
    page = agent.get("https://umanity.jp/racedata/db/horse_top.php?code=" + @code.to_s)

    # 馬の情報

    @text_right = page.search('div.text_right')
    @birth = elements_disassemble(@text_right).inner_text[14..31].delete('^年 月 日 0-9')
    @sex_age = elements_disassemble(@text_right).inner_text[8..13].delete('^牡 牝 セ 0-9')

    @uma_info = []
    @profs = page.search('table.race_prof_table td')
    # @uma_info << elements_disassemble(@profs)
    @profs.each do |prof|
      @uma_info << prof.inner_text
    end

      # 大元のテーブル
      @race_info = []
      @new_race_info = []
      @code_link = []

      # tdの塊を所得
      elements = page.search('table.racedata_race_chart_table td')
      elements_a = page.search('table.racedata_race_chart_table td a')

      elements.each do |element|
        @race_info << element.inner_text
      end

      elements_a.each do |element|
        if element.get_attribute('href').include?('//umanity.jp/racedata/race_21.php?code')
          @code_link << element.get_attribute('href')[39..55].to_s
        end
      end
      
      @code_link = @code_link.uniq

      @race_info.delete_at(0)
      @race_info.each_slice(23) do |i|
        i.delete_at(12)
        @new_race_info << i
      end

      @n = @new_race_info.transpose

    # favoriteの変数

    if logged_in?
      @user = current_user
      @favorite = Favorite.find_by(user_id: @user.id,uma_id:@uma.id)
    end

  end

  def elements_disassemble(e)
    e.each do |element|
      element.inner_text
    end
  end

end