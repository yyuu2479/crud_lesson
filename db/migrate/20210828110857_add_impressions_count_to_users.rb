class AddImpressionsCountToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :impressions_count, :integer, default: 0
  end
end
