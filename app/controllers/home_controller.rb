class HomeController < ApplicationController
before_action :current_user, {only: [:index]}

  def top

  end

  def index

  end
end
