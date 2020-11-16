class RaceController < ApplicationController
  def show
    p params[:name]
    @race = Race.find_by(code: params[:name])
  end
end
