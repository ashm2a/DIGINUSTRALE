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

  def edit
    porcs_abattage = @abattage.porcs.flat_map {|porc| porc }
    @porcs = Porc.where(id: porcs_abattage.pluck(:id))
  end

  def edit_produits
    porcs_abattage = @abattage.porcs.flat_map {|porc| porc }
    @porcs = Porc.where(id: porcs_abattage.pluck(:id))
  end

  def edit_lonzu
    @abattage = Abattage.find(params[:abattage_id])
    porcs_abattage = @abattage.porcs.flat_map {|porc| porc }
    @porcs = Porc.where(id: porcs_abattage.pluck(:id))
  end

  def edit_coppa
    @abattage = Abattage.find(params[:abattage_id])
    porcs_abattage = @abattage.porcs.flat_map {|porc| porc }
    @porcs = Porc.where(id: porcs_abattage.pluck(:id))
  end

  def edit_prisuttu
    @abattage = Abattage.find(params[:abattage_id])
    porcs_abattage = @abattage.porcs.flat_map {|porc| porc }
    @porcs = Porc.where(id: porcs_abattage.pluck(:id))
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
    porcs_abattage = @abattage.porcs.flat_map { |porc| porc }
    @porcs = Porc.where(id: porcs_abattage.pluck(:id))
    count = @porcs.count
    counter = 0
    count.times do
      porc_id = params[counter.to_s].keys.first
      porc = Porc.find(porc_id)
      porc.coppa.update(poids: params[counter.to_s][porc_id][:coppa][:poids])
      porc.coppa.update(date_mise_au_sel: params[counter.to_s][porc_id][:coppa][:date_mise_au_sel])
      porc.coppa.update(date_sortie_de_sel: params[counter.to_s][porc_id][:coppa][:date_sortie_de_sel])
      porc.coppa.update(durée_fumage: params[counter.to_s][porc_id][:coppa][:durée_fumage])
      porc.coppa.update(poids_sortie_sèche: params[counter.to_s][porc_id][:coppa][:poids_sortie_sèche])
      porc.coppa.update(date_entrée_affinage: params[counter.to_s][porc_id][:coppa][:date_entrée_affinage])
      porc.coppa.update(date_sortie_affinage_vente: params[counter.to_s][porc_id][:coppa][:date_sortie_affinage_vente])
      counter += 1
    end
    redirect_to abattage_path(@abattage)
  end

  def update_lonzu
    @abattage = Abattage.find(params[:abattage_id])
    porcs_abattage = @abattage.porcs.flat_map { |porc| porc }
    @porcs = Porc.where(id: porcs_abattage.pluck(:id))
    count = @porcs.count
    counter = 0
    count.times do
      porc_id = params[counter.to_s].keys.first
      porc = Porc.find(porc_id)
      porc.lonzu.update(poids: params[counter.to_s][porc_id][:lonzu][:poids])
      porc.lonzu.update(date_mise_au_sel: params[counter.to_s][porc_id][:lonzu][:date_mise_au_sel])
      porc.lonzu.update(date_sortie_de_sel: params[counter.to_s][porc_id][:lonzu][:date_sortie_de_sel])
      porc.lonzu.update(durée_fumage: params[counter.to_s][porc_id][:lonzu][:durée_fumage])
      porc.lonzu.update(poids_sortie_sèche: params[counter.to_s][porc_id][:lonzu][:poids_sortie_sèche])
      porc.lonzu.update(date_entrée_affinage: params[counter.to_s][porc_id][:lonzu][:date_entrée_affinage])
      porc.lonzu.update(date_sortie_affinage_vente: params[counter.to_s][porc_id][:lonzu][:date_sortie_affinage_vente])
      counter += 1
    end
    redirect_to abattage_path(@abattage)
  end

  def update_prisuttu
    @abattage = Abattage.find(params[:abattage_id])
    porcs_abattage = @abattage.porcs.flat_map { |porc| porc }
    @porcs = Porc.where(id: porcs_abattage.pluck(:id))
    count = @porcs.count
    counter = 0
    count.times do
      porc_id = params[counter.to_s].keys.first
      porc = Porc.find(porc_id)
      porc.prisuttu.update(poids: params[counter.to_s][porc_id][:prisuttu][:poids])
      porc.prisuttu.update(date_mise_au_sel: params[counter.to_s][porc_id][:prisuttu][:date_mise_au_sel])
      porc.prisuttu.update(date_sortie_de_sel: params[counter.to_s][porc_id][:prisuttu][:date_sortie_de_sel])
      porc.prisuttu.update(durée_fumage: params[counter.to_s][porc_id][:prisuttu][:durée_fumage])
      porc.prisuttu.update(poids_sortie_sèche: params[counter.to_s][porc_id][:prisuttu][:poids_sortie_sèche])
      porc.prisuttu.update(date_entrée_affinage: params[counter.to_s][porc_id][:prisuttu][:date_entrée_affinage])
      porc.prisuttu.update(date_sortie_affinage_vente: params[counter.to_s][porc_id][:prisuttu][:date_sortie_affinage_vente])
      counter += 1
    end
    redirect_to abattage_path(@abattage)
  end

  def download
    @coppa_temoin = Coppa.joins(:porc).where.not(date_mise_au_sel: nil).where(porcs: { abattage: @abattage }).first
    @lonzu_temoin = Lonzu.joins(:porc).where.not(date_mise_au_sel: nil).where(porcs: { abattage: @abattage }).first
    @prisuttu_temoin = Prisuttu.joins(:porc).where.not(date_mise_au_sel: nil).where(porcs: { abattage: @abattage }).first
    # html_content = render_to_string(template: 'abattages/download')
    # pdf = WickedPdf.new.pdf_from_string(html_content)
    # send_data(pdf,
    #           filename: 'document_aop.pdf',
    #           type: 'application/pdf',
    #           disposition: 'attachment')
    # save_path = Rails.root.join('pdfs','doc_aop.pdf')
    # File.open(save_path, 'wb') do |file|
    #   file << pdf
    # end
    # respond_to do |format|
    #   format.html
    #   format.pdf do
     render pdf: 'abattages/show',
            orientation: 'Landscape'
    # Excluding ".pdf" extension.
    #end
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
end
