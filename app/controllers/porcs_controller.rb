class PorcsController < ApplicationController
  before_action :set_porc, only: [:edit, :show, :update]

  def index
    @ipg = params[:ipg]
    @lot = params[:lot]

    if @ipg.present?
      @porcs = Porc.where("boucle ILIKE ?", "%#{@ipg}%")
    else
      @porcs = Porc.where(décès: false, abattu: false)
    end

    if @lot.present?
      @abattages = Abattage.where(numéro_lot: @lot.to_i)
    else
      @abattages = Abattage.all
    end
  end

  def new
    @porc = Porc.new
  end

  def create
    @porc = Porc.new(porc_params)
    # @porc.build_prisuttu
    # @porc.build_lonzu
    # @porc.build_coppa
    @porc.user = current_user
    if @porc.save!
      redirect_to porcs_path
    else
      render :new
    end
  end

  def show;
  end

  def gestion
    @porc = Porc.find(params[:porc_id])
    @selected_value_mere = @porc.boucle_mère
    @selected_value_pere = @porc.boucle_père
  end

  def edit
    @selected_value_mere = @porc.boucle_mère
    @selected_value_pere = @porc.boucle_père
  end

  def update
    if @porc.update(porc_params)
      if porc_params[:ph]
        render :edit
      else
        if porc_params[:décès] == "0"
          @porc.update(date_décès: "")
        end
        redirect_to porc_path(@porc)
      end
    else
      render :edit
    end
  end

  private

  def porc_params
    params.require(:porc).permit(:boucle, :boucle_mère, :boucle_père, :date_de_naissance, :sexe, :poids, :vermifuge_2_mois, :vermifuge_6_mois, :vermifuge_12_mois, :décès, :date_décès, :poids_carcasse, :epaisseur_lard, :ph, :coppa)
  end

  def set_porc
    @porc = Porc.find(params[:id])
  end
end
