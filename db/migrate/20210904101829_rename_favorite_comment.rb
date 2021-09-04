class RenameFavoriteComment < ActiveRecord::Migration[5.2]
  def change
    rename_column :notifications, :favorite_id, :comment_id
  end
end
