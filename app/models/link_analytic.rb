# == Schema Information
#
# Table name: link_analytics
#
#  id         :integer(8)      not null, primary key
#  link_id    :integer(8)
#  country    :string
#  ip_address :inet
#  agent      :text
#  created_at :datetime        not null
#  updated_at :datetime        not null
#
class LinkAnalytic < ApplicationRecord

  include AnalyticsMethods

  # Associations
  belongs_to :link, counter_cache: :clicks_count # custom column name

end

