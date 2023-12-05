class Link < ApplicationRecord
  belongs_to :user
  has_many :link_statistic
  has_many :link_access_details
  validates :url, presence: true, format: { with: URI.regexp }
end
