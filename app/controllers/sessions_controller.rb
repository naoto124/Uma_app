class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
     if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:success] = "ログイン" 
      redirect_to(root_path)

      else
      flash.now[:danger] = "入力が正しくありません、もう一度入力して下さい"
      render('new')
     end
  end

  def destroy
    log_out if logged_in?
    redirect_to(root_path)
  end

end
