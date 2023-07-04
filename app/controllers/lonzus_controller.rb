class LonzusController < ApplicationController
  before_action :set_lonzu, only: [:edit, :update]

  def new
    @lonzu = Lonzu.new
  end

  def create
    @lonzu = Lonzu.new(lonzu_params)
    @lonzu.porc = Porc.find_by(boucle: params[:porc][:boucle])
    if @lonzu.save
      redirect_to new_prisuttu_path
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  private

  def lonzu_params
    params.require(:lonzu).permit(:poids, :epaisseur_lard, :ph, :date_mise_au_sel, :date_sortie_de_sel, :durée_fumage, :poids_sortie_sèche, :date_entrée_affinage, :date_sortie_affinage_vente)
  end

  def set_lonzu
    @porc = Lonzu.find(params[:id])
  end

end
