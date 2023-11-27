class TemporalLink < Link
  has_one :link, as: :linkable
  validates :expiration_date, presence: true

  def redirect

  end
end
