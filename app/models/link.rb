class Link < ApplicationRecord
  belongs_to :user
  belongs_to :linkable, polymorphic: true  # Polymorphic association
  validates :url, presence: true

  def redirect
    linkable.redirect
  end


  class RegularLink < Link


    def redirect

    end
  end

  class TemporalLink < Link
    validates :expiration_date, presence: true

    def redirect

    end
  end

  class PrivateLink < Link
    validates :password, presence: true

    def redirect

    end
  end

  class EphemeralLink < Link
    def redirect

    end
  end
end
