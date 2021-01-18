class HomeController < ApplicationController
  before_action :current_user, {only: [:index]}
  before_action :logged_in_user, {only: [:index]}

  def top
    @q = Uma.ransack(params[:q])
    @uma_s = Kaminari.paginate_array(@q.result).page(params[:page]).per(5)
  end

  def index
    
  end

  def show
    
  end


end
