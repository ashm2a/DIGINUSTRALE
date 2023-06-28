class CoppasController < ApplicationController

  def create
    @abattage = Abattage.find(params[:id])
    q_coppa = params[:q_coppa]
    q_coppa.times do
      Coppa.create(porc: @abattage)
    end
  end
end
