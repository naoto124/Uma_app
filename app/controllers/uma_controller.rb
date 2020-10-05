
class UmaController < ApplicationController

  def index
    @umas = Uma.where('name like ?','ア%').page(params[:page]).per(80)
  end

end
