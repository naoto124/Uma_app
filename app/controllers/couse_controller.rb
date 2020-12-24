class CouseController < ApplicationController
  # def create
  #   c = Couse.all
  # end

  def index
    @c = Couse.all
    @couse_id = Couse.pluck(:id)

    @ple = []
    @type = []
    @name = []
    default = Couse.find_by(id:1)
    @default_speed = default.speed
    @default_power = default.power

    @c.each do |c|
      @ple << c.place
      @type << c.stage
      @name << c.couse_name
      # @default_speed << c.speed
      # @default_power << c.power
    end
    @ple = @ple.uniq!
    @type = @type.uniq!
      if logged_in?
        @user = current_user
      end

  end
end
