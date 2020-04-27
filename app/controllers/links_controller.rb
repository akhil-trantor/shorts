class LinksController < ApplicationController

  before_action :check_existing_link, only: [:create]

  def new
    @link = Link.new
  end

  def create
    unless @existing_link.present?
      @link = Link.new(link_params)
      if @link.valid?
        @link.set_ip_and_country(request)
        @link.save
      end
    end
  end

  def show
    link = Link.find_by slug: params[:slug]
    if link.present? && link.is_valid? && link.active?
      link.increment!(:clicks_count)
      redirect_to link.url and return
    else
      redirect_to :root, alert: 'Invalid short code' and return
    end
  end

  def stats
  end

  private

  def link_params
    params.require(:link).permit(:url)
  end

  def check_existing_link
    @existing_link = Link.where(url: Link.sanitized_url(link_params[:url])).first
  end

end
