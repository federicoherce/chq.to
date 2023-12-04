class LinkStatisticsController < ApplicationController

  def index
    @user_links = current_user.links
  end

end
