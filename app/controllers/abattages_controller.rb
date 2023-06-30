class AbattagesController < ApplicationController
  before_action :set_abattage, only: [:show, :edit, :update]

  def new
    @abattage = Abattage.new
    @porcs = Porc.where(décès: false, abattu: false)
  end

  def create
    @abattage = Abattage.new(abattage_params)
    if @abattage.save!
      @porcs = Porc.find(params[:porc_id])
      @porcs.each do |porc|
        porc.update!(abattage: @abattage)
        porc.update!(abattu: true)
      end
      redirect_to edit_abattage_path(@abattage)
    else
      render :new
    end
  end

  def show
  end

  def edit; end

  def update
    @abattage.porcs.update(porc_params)
    if @abattage.porcs.update
      redirect_to porcs_path
    else
      render :edit
    end
  end

  private

  def abattage_params
    params.require(:abattage).permit(:numéro_lot, :date, :lieu, :poids_carcasse, :ph, :epaisseur_lard,)
  end

  def set_abattage
    @abattage = Abattage.find(params[:id])
  end
end
