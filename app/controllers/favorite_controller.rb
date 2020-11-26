class FavoriteController < ApplicationController
  def create
    @user = current_user
    @uma = Uma.find(params[:uma_id])
    if Favorite.create(user_id: @user.id,uma_id:@uma.id)
      redirect_to uma_detail_path(name:@uma.name)
    else
      redirect_to root_url
    end
  end

  def update
    @user = current_user
    @uma = Uma.find(params[:uma_id])

    @favorite = Favorite.find_by(user_id: @user.id,uma_id:@uma.id)
    @favorite.update(parameter)

    if @favorite.update(parameter)
      redirect_to @uma
    else
      render root_path
    end
  end

  def edit
    @user = current_user
    @uma = Uma.find(params[:uma_id])
    @favorite = Favorite.find_by(user_id: @user.id,uma_id:@uma.id)
  end

  def destroy
    @user = current_user
    @uma = Uma.find(params[:uma_id])
    @favorite = Favorite.find_by(user_id: @user.id,uma_id:@uma.id)
    if @favorite = Favorite.find_by(user_id: @user.id,uma_id:@uma.id)
      @favorite.delete
      redirect_to uma_detail_path(name:@uma.name)
    else
      redirect_to root_url
    end
  end

  private
    def parameter
      params.require(:favorite).permit(:speed, :power)
    end
end