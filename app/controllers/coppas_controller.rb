class CoppasController < ApplicationController
  before_action :set_coppa, only: [:edit, :update]

  def new
    @coppa = Coppa.new
  end

  def create
    @coppa = Coppa.new(coppa_params)
    @coppa.porc = Porc.find_by(boucle: params[:porc][:boucle])
    if @coppa.save
      redirect_to new_lonzu_path
    else
      render :new
    end
  end

  def edit; end

  def update; end

  private

  def coppa_params
    params.require(:coppa).permit(:poids, :date_mise_au_sel, :date_sortie_de_sel, :durée_fumage, :poids_sortie_sèche, :date_entrée_affinage, :date_sortie_affinage_vente)
  end

  def set_coppa
    @porc = Coppa.find(params[:id])
  end
end
