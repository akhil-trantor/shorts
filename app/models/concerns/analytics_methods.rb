# The AnalyticsMethods module encapsulates all method related to analytics
module AnalyticsMethods
  extend ActiveSupport::Concern

  def set_analytics_data(request)
    self.ip_address = request.ip
    self.country    = request.location.country
    self.agent      = request.user_agent
  end

end
