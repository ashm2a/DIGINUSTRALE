class PrisuttusController < ApplicationController
  before_action :set_prisuttu, only: [:edit, :update]

  def new
    @prisuttu = Prisuttu.new
  end

  def create
    @prisuttu = Prisuttu.new(prisuttu_params)
    @prisuttu.porc = Porc.find_by(boucle: params[:porc][:boucle])
    if @prisuttu.save
      redirect_to abattage_path(@prisuttu.porc.abattage)
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  private

  def prisuttu_params
    params.require(:prisuttu).permit(:poids, :epaisseur_lard, :ph, :date_mise_au_sel, :date_sortie_de_sel, :durée_fumage, :poids_sortie_sèche, :date_entrée_affinage, :date_sortie_affinage_vente)
  end

  def set_prisuttu
    @porc = Prisuttu.find(params[:id])
  end


end
