
class UmaController < ApplicationController

  def index
    uma = Uma.all
  end

  def create
  end


  def show
    keyword = params[:link]
    @uma = Uma.where('name like ?',"#{keyword}%").page(params[:page]).per(80)
  end
end
