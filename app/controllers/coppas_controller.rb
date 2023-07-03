class CoppasController < ApplicationController
  before_action :set_porc, only: [:update]

  def create
    @abattage = Abattage.find(params[:id])

  end

  def update
    if @coppa.update(coppa_params)
      render :edit_produits_temoins
    else
      render :edit
    end
  end

  private

  def coppa_params
    params.require(:coppa).permit(:date_mise_au_sel, :date_sortie_de_sel, :durée_fumage, :poids_sortie_sèche, :date_entrée_affinage, :date_sortie_affinage_vente)
  end

end
