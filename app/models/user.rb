class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :porcs
  has_many :prisuttus, through: :porcs
  has_many :lonzus, through: :porcs
  has_many :coppas, through: :porcs
  validates :nom, :prénom, :EDE, :email, :mot_de_passe, :adresse, :code_postal, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
