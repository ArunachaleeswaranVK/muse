class RenameMuseToPost < ActiveRecord::Migration
  def change
    rename_table :muse, :post
  end
end
