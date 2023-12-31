class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :links, dependent: :destroy
  validates :username, uniqueness: true
end
