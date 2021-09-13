class RemoveUsersToGender < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :gender, :integer,  default: 0
  end
end
