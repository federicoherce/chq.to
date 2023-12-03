module ApplicationHelper
  def get_url
    if Rails.env.production?
      "https://chq.to/"
    elsif Rails.env.development?
      "http://127.0.0.1:3000/"
    end
  end
end
