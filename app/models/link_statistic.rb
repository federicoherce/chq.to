require 'date'

class LinkStatistic < ApplicationRecord
  belongs_to :link

  def increment_count(link)
    accessed_today = LinkStatistic.where(link_id: link.id, access_date: Date.current).first
    if accessed_today
      accessed_today.access_count += 1
      accessed_today.save
    else
      LinkStatistic.new(link_id: link.id, access_date: Date.current, access_count: 1)
    end
  end
end
