class LinkStatisticsController < ApplicationController
  before_action :authorize_user

  def show
    @link = Link.find(params[:id])

    start_date = params[:start_date]
    end_date = params[:end_date]
    ip_address = params[:ip_address]

    @link_access_details = @link.link_access_details

    @link_access_details = @link_access_details.where(access_datetime: start_date..end_date) if start_date.present? && end_date.present?
    @link_access_details = @link_access_details.where(ip_address: ip_address) if ip_address.present?
    @link_access_details = @link_access_details.paginate(page: params[:page], per_page: 4)

  end
end
