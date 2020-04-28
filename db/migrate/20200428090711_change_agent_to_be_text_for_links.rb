class ChangeAgentToBeTextForLinks < ActiveRecord::Migration[5.1]
  def change
    change_column :links, :agent, :text
    change_column :link_analytics, :agent, :text
  end
end
