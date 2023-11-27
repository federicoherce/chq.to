class RegularLink < Link
  has_one :link, as: :linkable
  def redirect

  end
end
