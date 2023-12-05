class LinkStatisticsController < ApplicationController

  def show
    @link = Link.find(params[:id])
  end

end
