class AbattagesController < ApplicationController
  before_action :set_abattage, only: [:show, :edit]

  def new
    @abattage = Abattage.new
    @porcs = Porc.where(décès: false, abattu: false)
  end

  def create
    @abattage = Abattage.new(abattage_params)
    if @abattage.save!
      porc_ids = params[:porc_ids].split(',')

      @porcs = Porc.where(id: porc_ids)
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
    @coppa_temoin = Coppa.joins(:porc).where.not(date_mise_au_sel: nil).where(porcs: { abattage: @abattage }).first
    @lonzu_temoin = Lonzu.joins(:porc).where.not(date_mise_au_sel: nil).where(porcs: { abattage: @abattage }).first
    @prisuttu_temoin = Prisuttu.joins(:porc).where.not(date_mise_au_sel: nil).where(porcs: { abattage: @abattage }).first
  end

  def dashboard
    @abattage = Abattage.find(params[:abattage_id])
    @products_per_porcs = @abattage.porcs.map do |porc|
      {
        porc_id: porc.boucle,
        lonzus: porc.lonzu.quantité,
        coppas: porc.coppa.quantité,
        prisuttus: porc.coppa.quantité
      }
    end
  end

  def edit
    porcs_abattage = @abattage.porcs.flat_map {|porc| porc }
    @porcs = Porc.where(id: porcs_abattage.pluck(:id))
  end

  def edit_produits
    @abattage = Abattage.find(params[:abattage_id])
    porcs_abattage = @abattage.porcs.flat_map {|porc| porc }
    @porcs = Porc.where(id: porcs_abattage.pluck(:id))
  end

  def update_abattage
    @abattage = Abattage.find(params[:abattage_id])
    porcs_abattage = @abattage.porcs.flat_map { |porc| porc }
    @porcs = Porc.where(id: porcs_abattage.pluck(:id))
    count = @porcs.count
    counter = 0
    count.times do
      porc = Porc.find(params[counter.to_s][:id])
      porc.update(ph: params[counter.to_s][:ph],
                  epaisseur_lard: params[counter.to_s][:epaisseur_lard],
                  poids_carcasse: params[counter.to_s][:poids_carcasse])
      counter += 1

      Coppa.create!(porc: porc) if porc.coppa.nil?
      Prisuttu.create!(porc: porc) if porc.prisuttu.nil?
      Lonzu.create!(porc: porc) if porc.lonzu.nil?
    end
    redirect_to abattage_path(@abattage)
  end

  def update_production
    @abattage = Abattage.find(params[:abattage_id])
    porcs_abattage = @abattage.porcs.flat_map { |porc| porc }
    @porcs = Porc.where(id: porcs_abattage.pluck(:id))
    count = @porcs.count
    counter = 0
      count.times do
        porc = Porc.find(params[counter.to_s][:id])
        porc.coppa.update(quantité: params[counter.to_s][:coppa][:quantité])
        porc.prisuttu.update(quantité: params[counter.to_s][:prisuttu][:quantité])
        porc.lonzu.update(quantité: params[counter.to_s][:lonzu][:quantité])
        counter += 1
      end
      redirect_to abattage_path(@abattage)
  end

  private

  def abattage_params
    params.require(:abattage).permit(:numéro_lot, :date, :lieu)
  end

  def set_abattage
    @abattage = Abattage.find(params[:id])
  end
end
