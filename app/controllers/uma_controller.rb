
class UmaController < ApplicationController

  def index
    @umas = Uma.where('name like ?',"#{keyword}%").page(params[:page]).per(80)

  end

  def create 
    @keyword = params[:name]

  end
end
