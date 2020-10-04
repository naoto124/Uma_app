
class UmaController < ApplicationController

  def index
    @umas = Uma.where('name like ?','ア%').page(params[:page]).per(40)
  end

end
