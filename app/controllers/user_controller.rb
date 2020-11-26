class UserController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to(root_path)
    else 
      render(singup_path)
    end

  end

  def show
    @user = User.find(params[:id])
    @umas = @user.uma

    favorites = Favorite.where(user_id: current_user.id).pluck(:uma_id)  # ログイン中のユーザーのお気に入りのpost_idカラムを取得
    @favorite_list = Uma.find(favorites)     # postsテーブルから、お気に入り登録済みのレコードを取得
  end

  private
  def user_params
    params.require(:user).permit(:id,:name,:email,:password,:password_confirmation)
  end
  
end
