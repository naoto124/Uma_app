class HomeController < ApplicationController
  before_action :current_user, {only: [:index]}
  before_action :logged_in_user, {only: [:index]}

  def top

  end

  def index
    
  end

  def show
    
  end

end
