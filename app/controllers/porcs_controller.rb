class PorcsController < ApplicationController
  before_action :set_porc, only: [:edit, :show]

  def index
    @porcs = Porc.where(décès: false, abattu: false)
    @abattages = Abattage.all
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
  end

  def edit
  end

  def update
    @porc = Porc.find(params[:id])
    if @porc.update(porc_params)
      redirect_to porc_path(@porc)
    else
      render :edit
    end
  end

  private

  def porc_params
    params.require(:porc).permit(:boucle, :boucle_mère, :boucle_père, :date_de_naissance, :sexe, :poids_carcasse, :epaisseur_lard, :ph)
  end

  def porc_porc_params
    params.require(:porc).permit(:boucle, :boucle_mère, :boucle_père, :date_de_naissance, :sexe, :poids_carcasse, :epaisseur_lard, :ph,)
  end

  def set_porc
    @porc = Porc.find(params[:id])
  end
end
