class CouseController < ApplicationController

  def create
    if CouseParameter.find_by(user_id:couse_params[:user_id],couse_id:couse_params[:couse_id]) == nil
      CouseParameter.create(couse_params)
      redirect_to couse_index_path
    elsif CouseParameter.find_by(user_id:couse_params[:user_id],couse_id:couse_params[:couse_id])
      p "uuuuu"
      @couse_parameter = CouseParameter.find_by(user_id:couse_params[:user_id],couse_id:couse_params[:couse_id])
      @couse_parameter.speed = couse_params[:speed]
      p @couse_parameter.speed
      @couse_parameter.power = couse_params[:power]
      p @couse_parameter.power
      @couse_parameter.save
      redirect_to couse_index_path
    else
      render root_url
    end

  end

  def index
    @c = Couse.all
    @couse_id = Couse.pluck(:id)

    @ples = []
    @type = []
    @names = []
    default = Couse.find_by(id:1)
    @default_speed = default.speed
    @default_power = default.power

    @c.each do |c|
      @ples << c.place
      @type << c.stage
      @names << c.couse_name
      # @default_speed << c.speed
      # @default_power << c.power
    end
    @ples = @ples.uniq!
    @type = @type.uniq!
      if logged_in?
        @user = current_user
        @parameters = CouseParameter.where(user_id:@user.id)
        p "ppppppp"
        p @parameters[10]
      end

  end

  private
  def couse_params
    params.require(:couse).permit(:couse_id, :user_id,:speed, :power)
  end
end
