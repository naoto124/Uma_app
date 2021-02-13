class CouseController < ApplicationController

  def create
    if Couse.couse_find(couse_params[:user_id],couse_params[:couse_id]) == nil
      CouseParameter.create(couse_params)
      redirect_to couse_index_path
    elsif Couse.couse_find(couse_params[:user_id],couse_params[:couse_id])
      @couse_parameter = Couse.couse_find(couse_params[:user_id],couse_params[:couse_id])
      @couse_parameter.speed = couse_params[:speed]
      @couse_parameter.power = couse_params[:power]
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
    default = Couse.couse_id(1)
    @default_speed = default.speed
    @default_power = default.power

    @c.each do |c|
      @ples << c.place
      @type << c.stage
      @names << c.couse_name
    end
    @ples = @ples.uniq!
    @type = @type.uniq!
      if logged_in?
        @user = current_user
        @parameters = CouseParameter.where(user_id:@user.id)
      end

  end

  private
  def couse_params
    params.require(:couse).permit(:couse_id, :user_id,:speed, :power)
  end
end
