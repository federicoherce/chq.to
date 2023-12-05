require 'date'

class LinkStatistic < ApplicationRecord
  belongs_to :link

  def self.increment_count(link)
    today = LinkStatistic.where(link_id: link.id, access_date: Date.current).first
    if today
      today.access_count += 1
      today.save
    else
      LinkStatistic.create(link_id: link.id, access_date: Date.current, access_count: 1)
    end
  end
end
