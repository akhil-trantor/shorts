class CreateLinkAnalytics < ActiveRecord::Migration[5.1]
  def change
    create_table :link_analytics do |t|
      t.belongs_to :link
      t.string  :country
      t.inet    :ip_address
      t.string  :agent
      t.timestamps
    end
  end
end
