class PrivateLink < Link
  has_secure_password

  def link_params
    params.require(:private_link).permit(:url, :type, :nombre, :password)
  end

  def redirect(entered_password)
    if authenticate(entered_password)
      { success: true }
    else
      { success: false, message: "Password is incorrect"}
    end
  end

end
