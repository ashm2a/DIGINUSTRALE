class Abattage < ApplicationRecord
  has_many :porcs
  validates :numéro_lot, :date, :lieu, presence: true
  ABATTOIRS = %w(Cuttoli Bastelica Cozzano Ponte\ Leccia)
  validates :lieu, inclusion: {in: ABATTOIRS}
end
