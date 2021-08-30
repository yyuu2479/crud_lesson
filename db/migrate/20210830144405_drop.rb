class Drop < ActiveRecord::Migration[5.2]
  def change
    drop_table :messages
    drop_table :entries
  end
end
