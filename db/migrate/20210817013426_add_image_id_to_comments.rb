class AddImageIdToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :image_id, :string
  end
end
