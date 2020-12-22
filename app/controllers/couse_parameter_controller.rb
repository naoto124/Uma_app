class CouseParameterController < ApplicationController
  def index
    @c = Couse.all
    @id = Couse.pluck(:id)
    @ple = []
    @type = []
    @name = []
    @speed = []
    @power = []
    @user = current_user
    p "uuuuuu"
    p @user
    @c.each do |c|
      p c.id
      parameter = CouseParameter.find_by(couse_id:c.id,user_id:@user.id)
      @speed << parameter.speed
      @power << parameter.power
      @ple << c.place
      @type << c.stage
      @name << c.couse_name
    end
    @ple = @ple.uniq!
    @type = @type.uniq!


  end

  def create

  end

  def update
    session[:user_id] = params[:user_id]
    @user = params[:user_id]
    @couse = Couse.find_by(id:params[:id])
    @params_id = Couse_parameter.find_by(user_id:session[:user_id],couse_id:@couse.id)

    @couse_parameter.speed = params[:speed]
    @couse_parameter.power = params[:power]
    if @favorite.save
      redirect_to couse_parameter_path
    else
      render root_url
    end

  end
end
