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

    @uma = Uma.find_by(name: params[:name])
    @code = @uma.code

    agent = Mechanize.new
    page = agent.get("https://db.netkeiba.com/horse/" + @code.to_s)

    @sex_age = page.at('p.txt_01')
    @prof_tds = page.search('table.db_prof_table td')
    @prof_tds_a = page.search('table.db_prof_table td a')

    @pedigree = page.search('table.blood_table a')
    # @race = page.at()

    # レース情報用

    @uma_race_a = page.search('table.db_h_race_results td a')
    @uma_race_right = page.search('td.txt_right')

  end

end

