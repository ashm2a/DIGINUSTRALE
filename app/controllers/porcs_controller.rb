class PorcsController < ApplicationController

  def index
    @porcs = Porc.where(décès: false, abattu: false)
  end

  def new
    @porc = Porc.new
  end

  def create
    @porc.user = 
    redirec_to #index porcs
  end

  def show
  end

  def edit
  end

  def update
  end
end
