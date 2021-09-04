class ChangeChecked < ActiveRecord::Migration[5.2]
  def change
    change_column :notifications, :checked, :string, default: 'false', null: false
  end
end
