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

  def edit
    porcs_abattage = @abattage.porcs.flat_map {|porc| porc }
    @porcs = Porc.where(id: porcs_abattage.pluck(:id))
  end

  def update
    porcs_abattage = @abattage.porcs.flat_map {|porc| porc }

    @porcs = Porc.where(id: porcs_abattage.pluck(:id))
    count = @porcs.count

    counter = 0

    count.times do
      porc = Porc.find(params[counter.to_s][:id])
      porc.update( ph: params[counter.to_s][:ph],
        epaisseur_lard: params[counter.to_s][:epaisseur_lard],
        poids_carcasse: params[counter.to_s][:poids_carcasse])
      counter += 1
    end
  end

  private

  def abattage_params
    params.require(:abattage).permit(:numéro_lot, :date, :lieu)
  end

  def set_abattage
    @abattage = Abattage.find(params[:id])
  end
end
