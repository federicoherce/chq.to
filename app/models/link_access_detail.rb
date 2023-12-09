class LinkAccessDetail < ApplicationRecord
  belongs_to :link

  def self.add_access(link, ip)
    fecha = DateTime.now.strftime("%d-%m-%Y %H:%M:%S")
    LinkAccessDetail.create(link_id: link.id, access_datetime: fecha, ip_address: ip)
  end

end
