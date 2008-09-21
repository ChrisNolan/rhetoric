class PostImportedId < ActiveRecord::Migration
  def self.up
    add_column :posts, :imported_id, :string, :limit => 10
  end

  def self.down
    remove_column :posts, :imported_id
  end
end
