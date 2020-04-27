class Link < ApplicationRecord

  # Constants
  UNIQUE_SLUG_LENGTH = 5
  VALID_FOR_DAYS = 30

  # Validations
  validates :url, url: true

  # Callbacks
  before_create :generate_slug
  before_create :set_valid_till
  before_save :sanitize_url

  # Scope
  enum status: [:active, :inactive]

  # Methods
  def set_ip_and_country(request)
    self.ip_address = request.ip
    self.country    = request.location.country
  end

  def is_valid?
    self.valid_till > Time.now
  end
  private

  def generate_slug
    new_slug = rand(36**UNIQUE_SLUG_LENGTH).to_s(36)
    if Link.where(slug: new_slug).exists?
      generate_slug
    else
      self.slug = new_slug
    end
  end

  def sanitize_url
    self.url.strip!
    self.url = self.url.downcase.gsub(/(https?:\/\/)|(www\.)/, "")
    self.url = "http://#{self.url}"
  end

  def set_valid_till
    self.valid_till = (Time.now + VALID_FOR_DAYS.days)
  end

end
