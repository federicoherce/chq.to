class Link < ApplicationRecord
  belongs_to :user
  has_many :link_statistic, dependent: :destroy
  has_many :link_access_details, dependent: :destroy
  validates :url, presence: true, format: { with: URI.regexp }
end
