class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  
  protect_from_forgery with: :null_session
  # form_forを使わないため,ブラウザの輻輳などのためのやつ

  include SessionsHelper
  include HomeHelper
  include UmaHelper

  private
    def logged_in_user
      unless logged_in?
        redirect_to(login_path)
      end
    end

  # before_action :set_current_user
  
  #   def set_current_user
  #     @current_user = User.find_by(id: session[:user_id])
  #   end

  # def authenticate_user
  #   if @current_user == nil
  #     flash[:notice] = "ログインが必要です"
  #     redirect_to("/login")
  #   end
  # end
  
  # def forbid_login_user
  #   if @current_user
  #     flash[:notice] = "すでにログインしています"
  #     redirect_to("/posts/index")
  #   end
  # end

end
