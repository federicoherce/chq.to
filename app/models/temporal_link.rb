require 'date'

class TemporalLink < Link
  validates :expiration_date, presence: true

  def redirect(_link)
    fecha = DateTime.parse(expiration_date)
    if fecha > DateTime.now.strftime("%Y-%m-%d %H:%M:%S")
      { success: true}
    else
      { success: false, status: 404 }
    end
  end

end
