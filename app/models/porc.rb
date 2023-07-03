class Porc < ApplicationRecord
  belongs_to :user
  belongs_to :abattage, optional: true
  has_one :prisuttu
  has_one :lonzu
  has_one :coppa
  accepts_nested_attributes_for :coppa, :prisuttu, :coppa
  validates :user, :boucle, :boucle_mère, :boucle_père, :date_de_naissance, :sexe, presence: true
  validates :sexe, inclusion: { in: %w[mâle femelle]}
end
