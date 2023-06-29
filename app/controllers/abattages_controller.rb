class AbattagesController < ApplicationController
  before_action :set_abattage, only: [:show, :edit, :update]

  def new
    @abattage = Abattage.new
  end

  def create
    @abattage = Abattage.new(abattage_params)
    if @abattage.save!
      redirect_to abattage_path(@abattage)
    else
      render :new
    end
  end

  def show
  end

  def edit; end

  def update
    # @abattage.porcs.update(porc_params)
    # if @abattage.porcs.update
    #   redirect_to porcs_path
    # else
    #   render :edit
    # end
  end

  private

  def abattage_params
    params.require(:abattage).permit(:numéro_lot, :date, :lieu, :poids_carcasse, :ph, :epaisseur_lard,)
  end

  def set_abattage
    @abattage = Abattage.find(params[:id])
  end
end
