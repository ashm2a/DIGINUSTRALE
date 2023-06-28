class PorcsController < ApplicationController

  def index
    @porcs = Porc.where(décès: false, abattu: false)
  end

  def new
    @porc = Porc.new
  end

  def create
    @porc = Porc.new(porc_params)
    @porc.user = current_user
    if @porc.save!
      redirect_to porcs_path
    else
      render :new
    end
  end

  
  def show
    @porc = Porc.find(params[:id])
  end

  def edit
  end

  def update
  end

  private

  def porc_params
    params.require(:porc).permit(:boucle, :boucle_mère, :boucle_père, :date_de_naissance, :sexe)
  end
end
