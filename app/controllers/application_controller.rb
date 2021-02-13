class ApplicationController < ActionController::Base
before_action :set_global_search_variable
  # protect_from_forgery with: :exception
  
  protect_from_forgery with: :null_session
  # form_forを使わないため,ブラウザの輻輳などのためのやつ

  include SessionsHelper
  include HomeHelper
  include UmaHelper
  include RaceHelper

  def set_global_search_variable
    @q = Uma.search(params[:q])
  end

  private
    def logged_in_user
      unless logged_in?
        redirect_to(login_path)
      end
    end

end
