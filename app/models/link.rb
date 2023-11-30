class Link < ApplicationRecord
  belongs_to :user
  validates :url, presence: true
end

def self.build(url, tipo, id)
  link_class = link_type.capitalize + 'Link'
  link = link_class.constantize.new(params)
  link.user_id = user_id
  link
  end

=begin
  def self.find_subclass(id)
    link = find(id)
    subclass_name = LINKS[link.tipo]

    if subclass_name.present? && subclass_name < Link
      link.becomes(subclass_name)
    else
      link
    end
  end
end
  LINKS = {
    'regular' => RegularLink,
    'temporal' => TemporalLink,
    'private' => PrivateLink,
    'ephemeral' => EphemeralLink
  }
=end
