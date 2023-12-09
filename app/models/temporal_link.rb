require 'date'

class TemporalLink < Link
  validates :expiration_date, presence: true

  def redirect(_link)
    if expiration_date > DateTime.now
      { success: true}
    else
      { success: false, status: 404 }
    end
  end

end
