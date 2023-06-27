class Porc < ApplicationRecord
  belongs_to :user
  belongs_to :abattage, optional: true
  validates :user, :boucle, :boucle_mère, :boucle_père, :date_de_naissance, :sexe, presence: true
end
