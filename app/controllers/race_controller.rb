require 'mechanize'
require "date"
require 'active_support/all'


class RaceController < ApplicationController


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
    @table_items = ["枠","馬番","馬名","性・歳","負荷","騎手","人気","馬s","馬p","コースs","コースp","条件値","合計値"]
    if Race.find_by(code: params[:name]) == nil
      race = Race.new
      race.code = params[:name]
      race.name = @race_title
      race.save ? (redirect_to request.referer) : (render :race_info_path) and return
    end
    @a = judge_result(params[:name].to_s)
    p @a
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
  end

  def result
    @code = params[:name]
    @table_items = ["着順","枠","馬番","馬名","性・歳","負荷","騎手","馬体重","オッズ","人気","タイム","着差","３F","通過","馬s","馬p","コースs","コースp","条件値","合計値"]
    run_result(params[:name].to_s)
  end


end