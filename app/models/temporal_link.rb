require 'date'

class TemporalLink < Link
  validates :expiration_date, presence: true

  def redirect(_link)
    fecha = eval(expiration_date)
    if Date.today < DateTime.new(fecha[1], fecha[2], fecha[3])
      { success: true}
    else
      { success: false, status: 404 }
    end
  end

end
