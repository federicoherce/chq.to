class Link < ApplicationRecord
  belongs_to :user
  belongs_to :linkable, polymorphic: true  # Polymorphic association
  validates :url, presence: true

  def redirect
    linkable.redirect
  end

end
