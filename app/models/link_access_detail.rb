class LinkAccessDetail < ApplicationRecord
  belongs_to :link

  def self.add_access(link, ip)
    LinkAccessDetail.create(link_id: link.id, access_datetime: Time.current, ip_address: ip)
  end
end
