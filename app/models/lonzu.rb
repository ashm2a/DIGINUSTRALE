class Lonzu < ApplicationRecord
  belongs_to :porc
  validates :numéro_lot, :poids, :epaisseur_lard, :ph, :date_mise_au_sel, :date_sortie_de_sel, :durée_fumage, :poids_sortie_sèche, :date_entrée_affinage, :date_sortie_affinage_vente, presence: true
end
