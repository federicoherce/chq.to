class Link < ApplicationRecord
  belongs_to :user
  validates :url, presence: true, format: { with: URI.regexp }
end
