require 'mechanize'

class UmaController < ApplicationController
  include UmaHelper


  def create
  end


  def show
    @keyword = params[:link]
    @uma = Uma.where_like(@keyword).page(params[:page]).per(80)
  end

  def detail

    # プロフィール用
    detail_item()
  end


  def search
    if params[:q]
      u = Uma.ransack(params[:q]).result
      if u.any?{|m| m.name == params[:q][:name_cont] }
        redirect_to uma_detail_path(name:params[:q][:name_cont])
      elsif u.any?{|m| m.name != params[:q][:name_cont] } && u
        @uma_s = Kaminari.paginate_array(u).page(params[:page]).per(5)
        redirect_to root_path
      else 
        flash[:primary] = "一致する条件がありません"
        redirect_to root_path
      end
    elsif params[:key]
      @input = Uma.where_like(params[:key].tr('ぁ-ん','ァ-ン'))
      @input = @input.select{|i| i[:name].length < 11}
      respond_to do |format|
        format.html
        format.json {render json: Kaminari.paginate_array(@input).page(params[:page]).per(5)}
      end
    end
  end

end

