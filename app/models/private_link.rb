class PrivateLink < Link
  validates :password, presence: true

  def redirect(entered_password)
    if (entered_password == password)
      { success: true }
    else
      { success: false, message: "Password is incorrect"}
    end
  end

end
