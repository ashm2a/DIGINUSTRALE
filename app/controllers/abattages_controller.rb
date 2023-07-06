class AbattagesController < ApplicationController
  before_action :set_abattage, only: [:show, :edit]
  before_action :set_abattage_id, only: [:edit_produits, :update_abattage, :update_production, :download]

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
      redirect_to abattage_path(@abattage)
    else
      render :new
    end
  end

  def show
    porcs_abattage = @abattage.porcs.flat_map {|porc| porc }
    @porcs = Porc.where(id: porcs_abattage.pluck(:id))

    coppas_with_weight = @porcs.map(&:coppa).select do |coppa|
      coppa&.poids&.positive?
    end
    @coppa_temoin = coppas_with_weight.first

    lonzus_with_weight = @porcs.map(&:lonzu).select do |lonzu|
      lonzu&.poids&.positive?
    end
    @lonzu_temoin = lonzus_with_weight.first

    prisuttus_with_weight = @porcs.map(&:prisuttu).select do |prisuttu|
      prisuttu&.poids&.positive?
    end
    @prisuttu_temoin = prisuttus_with_weight.first

    @etape_un_rempli = etape_un_rempli?(@abattage.porcs)
    @etape_deux_rempli = etape_deux_rempli?(@abattage.porcs)
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

  def edit_lonzu
    @abattage = Abattage.find(params[:abattage_id])
    porcs_abattage = @abattage.porcs.flat_map {|porc| porc }
    @porcs = Porc.where(id: porcs_abattage.pluck(:id))

    lonzus_with_weight = @porcs.map(&:lonzu).select do |lonzu|
      lonzu.poids&.positive?
    end
    @lonzu_temoin = lonzus_with_weight.first
  end

  def edit_coppa
    @abattage = Abattage.find(params[:abattage_id])
    porcs_abattage = @abattage.porcs.flat_map {|porc| porc }
    @porcs = Porc.where(id: porcs_abattage.pluck(:id))

    coppas_with_weight = @porcs.map(&:coppa).select do |coppa|
      coppa.poids&.positive?
    end
    @coppa_temoin = coppas_with_weight.first
  end

  def edit_prisuttu
    @abattage = Abattage.find(params[:abattage_id])
    porcs_abattage = @abattage.porcs.flat_map {|porc| porc }
    @porcs = Porc.where(id: porcs_abattage.pluck(:id))

    prisuttus_with_weight = @porcs.map(&:prisuttu).select do |prisuttu|
      prisuttu.poids&.positive?
    end
    @prisuttu_temoin = prisuttus_with_weight.first
  end

  def update_abattage
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
    porcs_abattage = @abattage.porcs.flat_map { |porc| porc }
    @porcs = Porc.where(id: porcs_abattage.pluck(:id))
    count = @porcs.count
    counter = 0
      count.times do
        porc = Porc.find(params[counter.to_s][:id])
        porc.coppa.update(quantité: params[counter.to_s][:coppa][:quantité], numéro_lot: @abattage.id)
        porc.prisuttu.update(quantité: params[counter.to_s][:prisuttu][:quantité], numéro_lot: @abattage.id)
        porc.lonzu.update(quantité: params[counter.to_s][:lonzu][:quantité], numéro_lot: @abattage.id)
        counter += 1
      end
      redirect_to abattage_path(@abattage)
  end

  def update_coppa
    @abattage = Abattage.find(params[:abattage_id])
    ipg = params[:ipg]
    porc = Porc.find_by(boucle: ipg)

    @abattage.porcs.each do |p|
      p.coppa.update(poids: nil)
      p.coppa.update(date_mise_au_sel: nil)
      p.coppa.update(date_sortie_de_sel: nil)
      p.coppa.update(durée_fumage: nil)
      p.coppa.update(poids_sortie_sèche: nil)
      p.coppa.update(date_entrée_affinage: nil)
      p.coppa.update(date_sortie_affinage_vente: nil)
    end

    porc.coppa.update(poids: params[:poids])
    porc.coppa.update(date_mise_au_sel: params[:date_mise_au_sel])
    porc.coppa.update(date_sortie_de_sel: params[:date_sortie_de_sel])
    porc.coppa.update(durée_fumage: params[:durée_fumage])
    porc.coppa.update(poids_sortie_sèche: params[:poids_sortie_sèche])
    porc.coppa.update(date_entrée_affinage: params[:date_entrée_affinage])
    porc.coppa.update(date_sortie_affinage_vente: params[:date_sortie_affinage_vente])

    redirect_to abattage_path(@abattage)
  end

  def update_prisuttu
    @abattage = Abattage.find(params[:abattage_id])
    ipg = params[:ipg]
    porc = Porc.find_by(boucle: ipg)

    @abattage.porcs.each do |p|
      p.prisuttu.update(poids: nil)
      p.prisuttu.update(epaisseur_lard: nil)
      p.prisuttu.update(ph: nil)
      p.prisuttu.update(date_mise_au_sel: nil)
      p.prisuttu.update(date_sortie_de_sel: nil)
      p.prisuttu.update(durée_fumage: nil)
      p.prisuttu.update(poids_sortie_sèche: nil)
      p.prisuttu.update(date_entrée_affinage: nil)
      p.prisuttu.update(date_sortie_affinage_vente: nil)
    end

    porc.prisuttu.update(poids: params[:poids])
    porc.prisuttu.update(epaisseur_lard: params[:epaisseur_lard])
    porc.prisuttu.update(ph: params[:ph])
    porc.prisuttu.update(date_mise_au_sel: params[:date_mise_au_sel])
    porc.prisuttu.update(date_sortie_de_sel: params[:date_sortie_de_sel])
    porc.prisuttu.update(durée_fumage: params[:durée_fumage])
    porc.prisuttu.update(poids_sortie_sèche: params[:poids_sortie_sèche])
    porc.prisuttu.update(date_entrée_affinage: params[:date_entrée_affinage])
    porc.prisuttu.update(date_sortie_affinage_vente: params[:date_sortie_affinage_vente])

    redirect_to abattage_path(@abattage)
  end

  def update_lonzu
    @abattage = Abattage.find(params[:abattage_id])
    ipg = params[:ipg]
    porc = Porc.find_by(boucle: ipg)

    @abattage.porcs.each do |p|
      p.lonzu.update(poids: nil)
      p.lonzu.update(date_mise_au_sel: nil)
      p.lonzu.update(date_sortie_de_sel: nil)
      p.lonzu.update(durée_fumage: nil)
      p.lonzu.update(poids_sortie_sèche: nil)
      p.lonzu.update(date_entrée_affinage: nil)
      p.lonzu.update(date_sortie_affinage_vente: nil)
    end

    porc.lonzu.update(poids: params[:poids])
    porc.lonzu.update(date_mise_au_sel: params[:date_mise_au_sel])
    porc.lonzu.update(date_sortie_de_sel: params[:date_sortie_de_sel])
    porc.lonzu.update(durée_fumage: params[:durée_fumage])
    porc.lonzu.update(poids_sortie_sèche: params[:poids_sortie_sèche])
    porc.lonzu.update(date_entrée_affinage: params[:date_entrée_affinage])
    porc.lonzu.update(date_sortie_affinage_vente: params[:date_sortie_affinage_vente])

    redirect_to abattage_path(@abattage)
  end

  def download
    @abattage = Abattage.find(params[:abattage_id])
    porcs_abattage = @abattage.porcs.flat_map {|porc| porc }
    @porcs = Porc.where(id: porcs_abattage.pluck(:id))

    coppas_with_weight = @porcs.map(&:coppa).select do |coppa|
      coppa&.poids&.positive?
    end
    @coppa_temoin = coppas_with_weight.first

    lonzus_with_weight = @porcs.map(&:lonzu).select do |lonzu|
      lonzu&.poids&.positive?
    end
    @lonzu_temoin = lonzus_with_weight.first

    prisuttus_with_weight = @porcs.map(&:prisuttu).select do |prisuttu|
      prisuttu&.poids&.positive?
    end
    @prisuttu_temoin = prisuttus_with_weight.first

    render pdf: 'abattages/show',
           orientation: 'Landscape'
  end

  private

  def abattage_params
    params.require(:abattage).permit(:numéro_lot, :date, :lieu)
  end

  def set_abattage
    @abattage = Abattage.find(params[:id])
  end

  def set_abattage_id
    @abattage = Abattage.find(params[:abattage_id])
  end

  def etape_un_rempli?(porcs)
    porcs.all? do |porc|
      porc.poids_carcasse.present? &&
      porc.epaisseur_lard.present? &&
      porc.ph.present? &&
      porc.poids_carcasse != 0 &&
      porc.epaisseur_lard != 0 &&
      porc.ph != 0
    end
  end

  def etape_deux_rempli?(porcs)
    porcs.all? do |porc|
      !porc.coppa&.quantité.nil? &&
      !porc.lonzu&.quantité.nil? &&
      !porc.prisuttu&.quantité.nil?
    end
  end
end
