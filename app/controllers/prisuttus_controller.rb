class PrisuttusController < ApplicationController

  def create
    q_prisuttu = params[:q_prisuttu]
    q_prisuttu.times do
      Prisuttu.create
    end
  end

end
