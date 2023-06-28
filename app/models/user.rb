class User < ApplicationRecord
  has_many :porcs
  has_many :prisuttus, through: :porcs
  has_many :lonzus, through: :porcs
  has_many :coppas, through: :porcs

  validates_presence_of :nom, :prénom, :EDE, :adresse, :ville, :code_postal
  validates :password, presence: true, confirmation: true, if: :password_required?

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  private

  def password_required?
    new_record? || password.present? || password_confirmation.present?
  end
end
