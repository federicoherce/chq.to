class Link < ApplicationRecord
  enum link_type: { regular: 0, temporal: 1, privado: 2, efimero: 3 }
  belongs_to :user
  validates :url, presence: true
  validates :link_type, presence: true
end
