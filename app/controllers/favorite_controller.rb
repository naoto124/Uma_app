class FavoriteController < ApplicationController
  def create
    @user = current_user
    if Favorite.favorite_create(@user.id,params[:uma_id])
      @uma = Favorite.uma_find(@user.id,params[:uma_id])
      redirect_to uma_detail_path(name:@uma.name)
    else
      render root_url
    end
  end


  def update
    session[:user_id] = params[:user_id]
    @favorite = Favorite.find_favorite(session[:user_id],params[:uma_id])
    @favorite.speed = params[:speed]
    @favorite.power = params[:power]
    if @favorite.save
      @uma = Favorite.uma_find(session[:user_id],params[:uma_id])
      redirect_to uma_detail_path(name:@uma.name)
    else
      render root_url
    end
  end


  def destroy
      @uma = Favorite.uma_find(session[:user_id],params[:uma_id])
    @favorite = Favorite.find_favorite(session[:user_id],@uma.id)
    if @favorite = Favorite.find_favorite(session[:user_id],@uma.id)
      @favorite.delete
      redirect_to uma_detail_path(name:@uma.name)
    else
      render uma_detail_path
    end
  end

  private
    def parameter
      params.require(:favorite).permit(:speed, :power)
    end
end