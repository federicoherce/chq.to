class PrivateLink < Link
  has_secure_password

  def redirect(entered_password)
    if authenticate(entered_password)
      { success: true }
    else
      { success: false, message: "La contraseña es incorrecta"}
    end
  end

end
