class Link < ApplicationRecord
  belongs_to :user
  has_one :link_statistic
  validates :url, presence: true, format: { with: URI.regexp }
end
