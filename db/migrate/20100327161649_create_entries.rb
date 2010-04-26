class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|
      t.string :url
      t.string :title
      t.text :content
      t.references :feed

      t.timestamps
    end
  end

  def self.down
    drop_table :entries
  end
end
