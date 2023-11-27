class PrivateLink < Link
  has_one :link, as: :linkable
  validates :password, presence: true

  def redirect

  end
end
