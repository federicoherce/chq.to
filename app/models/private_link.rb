class PrivateLink < Link
  validates :password, presence: true

  def redirect
    p "redireccion p"

  end
end
