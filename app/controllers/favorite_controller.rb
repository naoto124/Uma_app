class FavoriteController < ApplicationController
  def create
    p "---------"
    p params
    @user = current_user
    if Favorite.favorite_create(params[:uma_id],@user.id)
      uma = Uma.new
      @uma = uma.uma_find_id(params[:uma_id])
      redirect_to uma_detail_path(name:@uma.name)
    else
      render root_url
    end
  end

  def update
    p "---------"
    p params
    session[:user_id] = params[:user_id]
    @user = params[:user_id]
    u = Uma.new
    @uma = u.uma_find_id(params[:uma_id])
    @favorite = Favorite.find_favorite(session[:user_id],@uma.id)
    # @favorite = Favorite.find_by(user_id: session[:user_id],uma_id:@uma.id)
    p "---------"
    p @favorite
    p @user
    p @current_user
    p @uma
    p session[:user_id]
    p params[:favorite]
    @favorite.speed = params[:speed]
    @favorite.power = params[:power]
    # if @favorite.update(parameter)
    if @favorite.save
      redirect_to uma_detail_path(name:@uma.name)
    else
      render root_url
    end
  end

  # def edit
  #   @user = current_user
  #   @uma = Uma.find(params[:uma_id])
  #   @favorite = Favorite.find_by(user_id: @user.id,uma_id:@uma.id)
  # end

  def destroy
    p "---------"
    p params
    @user = current_user
      uma = Uma.new
      @uma = uma.uma_find_id(params[:uma_id])
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