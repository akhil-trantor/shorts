class CreateLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :links do |t|
      t.text    :url
      t.string  :slug
      t.integer :clicks_count
      t.string  :country
      t.inet    :ip_address
      t.integer :status, default: 0
      t.timestamp :valid_upto
      t.timestamps
    end
  end
end
