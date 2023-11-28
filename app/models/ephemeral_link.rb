class EphemeralLink < Link
  validates :entered, inclusion: { in: [true, false] }
  def redirect
    p "redireccion e"
  end
end
