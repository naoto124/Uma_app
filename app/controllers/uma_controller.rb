require 'mechanize'

class UmaController < ApplicationController
  include UmaHelper

  def index
    @user_id = session[:user_id]
    p session[:user_id]
    p "eeeee"
    @uma = Uma.all
    @favorite = Favorite.where(user_id:@user_id)
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
end

