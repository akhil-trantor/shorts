class LinkAnalytic < ApplicationRecord

  include AnalyticsMethods

  # Associations
  belongs_to :link, counter_cache: :clicks_count # custom column name

end
