class RegularLink < Link

  def redirect(_link)
    { success: true }
  end
end
