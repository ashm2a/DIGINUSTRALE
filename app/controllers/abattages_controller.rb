class AbattagesController < ApplicationController
  before_action :set_abattage, only: [:show, :edit, :update]
  def index
    @abattages = Abattage.all
  end

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

  def update
    @abattage.update(params[:abattage])
    redirect_to abattage_path(@abattage)
  end

  def edit
  end

  private

  def abattage_params
    params.require(:abattage).permit(:numéro_lot, :date, :lieu)
  end

  def set_abattage
    @abattage = Abattage.find(params[:id])
  end
end
