class CoppasController < ApplicationController
  before_action :set_coppa, only: [:edit, :update]

  def new
    @coppa = Coppa.new
  end

  def create
    @abattage = Abattage.find(params[:id])
  end

  def edit
  end

  def update
  end

  private

  def coppa_params
    params.require(:coppa).permit(:date_mise_au_sel, :date_sortie_de_sel, :durée_fumage, :poids_sortie_sèche, :date_entrée_affinage, :date_sortie_affinage_vente)
  end

  def set_coppa
    @porc = Coppa.find(params[:id])
  end

end
