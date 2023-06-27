class AbattagesController < ApplicationController

  def index
    @abattages = Abattage.all
  end

  def new
    @abattage = Abattage.new
  end

  def create
  end

  def show
  end

  def update
  end

  def edit
  end
end
