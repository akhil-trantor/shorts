class Link < ApplicationRecord

  include AnalyticsMethods

  # Constants
  UNIQUE_SLUG_LENGTH = 5
  VALID_FOR_DAYS = 30

  # Validations
  validates :url, url: true

  # Associations
  has_many :link_analytics, dependent: :destroy

  # Callbacks
  before_create :generate_slug
  before_create :set_valid_till
  before_save :set_sanitized_url

  # Scope
  enum status: [:active, :inactive]

  # Methods

  def is_valid?
    self.valid_till > Time.now
  end

  def self.sanitized_url(url)
    url.strip!
    url = url.downcase.gsub(/(https?:\/\/)|(www\.)/, "")
    return "http://#{ url }"
  end

  def save_analytics_data(request)
    analytics = self.link_analytics.new
    analytics.set_analytics_data(request)
    analytics.save
  end

  def top_countries
    link_countries = link_analytics.pluck(:country)
    return [] if (link_analytics.blank? || link_countries.blank?)
    link_countries.flatten.group_by {|country_name| country_name}.sort_by {|_, country_arr| -country_arr.count}.map(&:first)
  end

  private

  def generate_slug
    new_slug = rand(36**UNIQUE_SLUG_LENGTH).to_s(36)
    if Link.where(slug: new_slug).exists? || new_slug.length != UNIQUE_SLUG_LENGTH
      generate_slug
    else
      self.slug = new_slug
    end
  end

  def set_sanitized_url
    self.url = Link.sanitized_url(self.url)
  end

  def set_valid_till
    self.valid_till = (Time.now + VALID_FOR_DAYS.days)
  end

end
