class EphemeralLink < Link
  validates :entered, inclusion: { in: [true, false] }

  def redirect(link)
    if not entered
      link.update(entered: true)
      { success: true }
    else
      { success: false, status: 403 }
    end
  end

end
