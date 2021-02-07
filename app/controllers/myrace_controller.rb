# class MyraceController < ApplicationController
#     def create
#     p "---------"
#     p params
#     @user = current_user
#     if Favorite.favorite_create(params[:race_id],@user.id)
#       race = Race.new
#       @race = race.race_find_id(params[:race_id])
#       redirect_to race_run_path(name:@race.name)
#     else
#       render root_url
#     end
#   end

#   def update
#     p "---------"
#     p params
#     session[:user_id] = params[:user_id]
#     @user = params[:user_id]
#     u = Race.new
#     @race = u.race_find_id(params[:uma_id])
#     @race = Myrace.find_myrace(session[:user_id],@race.id)
#     # @myrace = Myrace.find_by(user_id: session[:user_id],race_id:@race.id)
#     p "---------"
#     p @myrace
#     p @user
#     p @current_user
#     p @race
#     p session[:user_id]
#     p params[:myrace]
#     @myrace.speed = params[:speed]
#     @myrace.power = params[:power]
#     # if @myrace.update(parameter)
#     if @myrace.save
#       redirect_to uma_detail_path(name:@uma.name)
#     else
#       render root_url
#     end
#   end


#   def destroy
#     p "---------"
#     p params
#     @user = current_user
#       race = Race.new
#       @race = race.race_find_id(params[:race_id])
#     @myrace = Myrace.find_myrace(session[:user_id],@race.id)
#     if @myrace = Myrace.find_myrace(session[:user_id],@race.id)
#       @favorite.delete
#       redirect_to race_run_path(name:@race.name)
#     else
#       render race_run_path
#     end
#   end

#   private
#     def parameter
#       params.require(:myrace).permit(:speed, :power)
#     end
# end
