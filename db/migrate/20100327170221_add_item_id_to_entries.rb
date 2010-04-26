class AddItemIdToEntries < ActiveRecord::Migration
  def self.up
    add_column :entries, :item_id, :string
  end

  def self.down
    remove_column :entries, :item_id
  end
end
