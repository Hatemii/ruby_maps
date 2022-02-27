class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_presence_of :name, :username, :password_confirmation
  validates_uniqueness_of :username, :email

  has_many :pets
  has_many :found_pets
end
