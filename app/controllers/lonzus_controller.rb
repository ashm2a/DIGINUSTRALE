class LonzusController < ApplicationController

  def create
    q_lonzu = params[:q_lonzu]
    q_lonzu.times do
      Lonzu.create
    end
  end

end
