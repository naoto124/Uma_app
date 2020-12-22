class CouseController < ApplicationController

  def index
    @c = Couse.all
    @ple = []
    @type = []
    @name = []
    @speed = []
    @power = []

    @c.each do |c|
      @ple << c.place
      @type << c.stage
      @name << c.couse_name
      @speed << c.speed
      @power << c.power
    end
    @ple = @ple.uniq!
    @type = @type.uniq!
    p @name
  end
end
