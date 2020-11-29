class FavoriteController < ApplicationController
  def create
    p "---------"
    p params
    @user = current_user
    @uma = Uma.find(params[:uma_id])
    if Favorite.create(user_id: @user.id,uma_id:@uma.id)
      redirect_to uma_detail_path(name:@uma.name)
    else
      render root_url
    end
  end

  def update
    p "---------"
    p params
    @user = current_user
    @uma = Uma.find_by(params[:uma_id])
    uma_id = @uma.id
    @favorite = Favorite.find_by(user_id: @user.id,uma_id:@uma.id)
    p "---------"
    p params[:speed]
    
    if @favorite.update(parameter)
      @favorite.update(parameter)
      redirect_to uma_detail_path(name:@uma.name)
    else
      render root_url
    end
  end

  def edit
    @user = current_user
    @uma = Uma.find(params[:uma_id])
    @favorite = Favorite.find_by(user_id: @user.id,uma_id:@uma.id)
  end

  def destroy
    p "---------"
    p params
    @user = current_user
    @uma = Uma.find(params[:uma_id])
    @favorite = Favorite.find_by(user_id: @user.id,uma_id:@uma.id)
    if @favorite = Favorite.find_by(user_id: @user.id,uma_id:@uma.id)
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