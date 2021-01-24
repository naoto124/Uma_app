require 'mechanize'

class UmaController < ApplicationController
  include UmaHelper

  def index
    @user_id = session[:user_id]
    p session[:user_id]
    p "eeeee"
    my_favorite(@user_id)
  end

  def create
  end


  def show
    @keyword = params[:link]
    @uma = Uma.where('name like ?',"#{@keyword}%").page(params[:page]).per(80)
      
  end

  def detail

    # プロフィール用
    detail_item()
  end

  # def all_index
  #   unless params[:q].blank?
  #   @q = Uma.search(params[:q])
  #   p "uuu"
  #   p @q.result
  #   @uma_s = Kaminari.paginate_array(@q.result).page(params[:page]).per(5)
  #   p @uma_s
  # else

  # end
  # end

  def search
    p "yyy"
    p params[:key]
    if params[:q]
      u = Uma.ransack(params[:q]).result
      # @q = Uma.ransack(params[:q])
      # p u.any?{|m| m.name == params[:name_cont] }
      if u.any?{|m| m.name == params[:q][:name_cont] }
        p "iiii"
        redirect_to uma_detail_path(name:params[:q][:name_cont])
      elsif u.any?{|m| m.name != params[:q][:name_cont] } && u
        p "ooo"
        @uma_s = Kaminari.paginate_array(u).page(params[:page]).per(5)
        redirect_to root_path
      else 
        flash[:primary] = "一致する条件がありません"
        redirect_to root_path
      end
    elsif params[:key]
      p "iiiii"
      @input = Uma.where('name LIKE(?)', "#{params[:key]}%")
      @input = @input.select{|i| i[:name].length < 11}
      p "iiiii"
      p @input
      respond_to do |format|
        format.html
        format.json {render json: Kaminari.paginate_array(@input).page(params[:page]).per(5)}
      end
    end
  end

end

