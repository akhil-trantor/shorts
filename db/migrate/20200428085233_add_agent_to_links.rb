class AddAgentToLinks < ActiveRecord::Migration[5.1]
  def change
    add_column :links, :agent, :string
  end
end
