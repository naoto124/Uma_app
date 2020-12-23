class CouseParameterController < ApplicationController
  def index
    @c = Couse.all
    @couse_parameter = CouseParameter.new
    @couse_parameters = CouseParameter.all 
    @id = Couse.pluck(:id)
    @ple = []
    @type = []
    @name = []
    default = Couse.find_by(id:1)
    @default_speed = default.speed
    @default_power = default.power
    @speed = []
    @power = []
    @user = current_user
    p "uuuuuu"
    # p @user
    @c.each do |c|
      # p c.id
      
      if CouseParameter.find_by(couse_id:c.id,user_id:@user.id)
        parameter = CouseParameter.find_by(couse_id:c.id,user_id:@user.id)
        @speed << parameter.speed
        @power << parameter.power
      end

      @ple << c.place
      @type << c.stage
      @name << c.couse_name
    end
    @ple = @ple.uniq!
    @type = @type.uniq!


  end

  def create
    session[:user_id] = params[:user_id]
    @user = params[:user_id]
    @couse = Couse.find_by(id:params[:id])
    p "ppppp"
    p @couse
    p session[:user_id]

    if @couse_parameter.create(user_id:session[:user_id],couse_id:@couse.id,speed:params[:speed],power:params[:power])
      redirect_to couse_parameter_path
    else
      render root_url
    end

  end

  def update
    session[:user_id] = params[:user_id]
    @user = params[:user_id]
    @couse = Couse.find_by(id:params[:id])
    @couse_parameter = Couse_parameter.find_by(user_id:session[:user_id],couse_id:@couse.id)

    @couse_parameter.speed = params[:speed]
    @couse_parameter.power = params[:power]
    if @couse_parameter.save
      redirect_to couse_parameter_path
    else
      render root_url
    end

  end
end
