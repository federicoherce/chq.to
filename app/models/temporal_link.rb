require 'date'

class TemporalLink < Link

  validates :expiration_date, presence: true

  def redirect(link)
    fecha = eval(expiration_date)
    Date.today < DateTime.new(fecha[1], fecha[2], fecha[3], fecha[4], fecha[5])
  end
end
