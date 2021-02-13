class UserController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to(root_path)
    else 
      render('new')
    end

  end

  def show
    @user = User.find(params[:id])
    @umas = @user.uma

    favorites = Favorite.where(user_id: current_user.id).pluck(:uma_id)  # ログイン中のユーザーのお気に入りのpost_idカラムを取得
    @favorite_list = Uma.find(favorites)     # postsテーブルから、お気に入り登録済みのレコードを取得
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_back_or("/user/#{session[:user_id]}/edit")
    else
      render 'edit'
    end
  end

  def index
    @user_id = session[:user_id]
    @favorite_uma = User.my_favorites(@user_id,params[:page])
    @favorites = []
    @favorite_uma.each do |uma|
      @favorites << User.favorite(@user_id,uma)
    end
  end


  private
  def user_params
    params.require(:user).permit(:id,:name,:email,:password,:password_confirmation)
  end

  def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインして下さい"
        redirect_to login_url
      end
  end

  def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
  end

  
end
