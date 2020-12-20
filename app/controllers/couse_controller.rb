class CouseController < ApplicationController

  def index
    @c = Couse.all
  end
end
