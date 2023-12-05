require 'date'

class TemporalLink < Link
  validates :expiration_date, presence: true

  def redirect(_link)
    fecha = eval(expiration_date)
    if DateTime.now.strftime("%Y-%m-%d %H:%M:%S") < DateTime.new(fecha[1], fecha[2], fecha[3], fecha[4], fecha[5]).strftime("%Y-%m-%d %H:%M:%S")
      { success: true}
    else
      { success: false, status: 404 }
    end
  end

end
