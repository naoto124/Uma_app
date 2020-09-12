class SessionsController < ApplicationController
  def new
  end

  def create

    user = User.find_by(email: params[:session][:email].downcase)
     if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:notice] = "ログイン" 
      redirect_to(root_path)
     else
      render('new')
     end

    # @user = User.find_by(email:params[:email],password_digest:params[:password],password_digest:params[:password_confirmation])
    # if @user
    #   session[:user_id] = @user.id
    #   flash[:notice] = "ログインしました"
    #   redirect_to(root_path)
    # else
    #   @error_message = "メールアドレスまたはパスワードが間違っています"
    #   @email = params[:email]
    #   @password = params[:password]
    #   @password_confirmation = params[:password_confirmation]
    #   render(/login)
    # end
  end



  def destroy
    log_out if logged_in?
    redirect_to(root_path)
  end

  # private
  # def login_params
  #   params.require(:user).permit(:email,:password_digest)
  # end

end
