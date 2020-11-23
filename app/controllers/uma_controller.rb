require 'mechanize'

class UmaController < ApplicationController
  include UmaHelper

  def index
    uma = Uma.all
  end

  def create
  end


  def show
    @keyword = params[:link]
    @uma = Uma.where('name like ?',"#{@keyword}%").page(params[:page]).per(80)
      
  end

  def detail

    # プロフィール用
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
      # 分解したテーブル

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
      # 22個のtitleにいれる22個の要素を1として所得

      # pが出力されない

      # @race_infoは配列でdeleteやsliceは無視してください
      @race_info.delete_at(0)
      @race_info.each_slice(23) do |i|
        i.delete_at(12)
        @new_race_info << i
      end

      # pが出力される
      p @new_race_info[0]
      p @code_link[0]
      @n = @new_race_info.transpose



      # titleの別に要素を変数にいれる
      # @new_race_info.each do |n|
      #   m = 0
      #   for m in 0..21 do
      #  @table[m] << n[m].to_s
      #   end
      # end


  end

  def elements_disassemble(e)
    e.each do |element|
      element.inner_text
    end
  end
  
  def elements_disassemble_a(e)
    e.each do |element|
      element.get_attribute('href')
    end
  end

end

