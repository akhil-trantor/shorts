class RenameValidUpto < ActiveRecord::Migration[5.1]
  def change
    rename_column :links, :valid_upto, :valid_till
  end
end
