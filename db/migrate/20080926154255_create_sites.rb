class CreateSites < ActiveRecord::Migration
  def self.up
    create_table :sites do |t|
      t.integer :user_id
      t.string :url
      t.string :title
      t.text :description
      t.string :keywords
      t.integer :per_page, :limit => 4
      t.integer :headlines_max, :limit => 2
      t.string :headlines_title

      t.timestamps
    end
    
    rename_column :posts, :blog_id, :site_id
    add_index :posts, [:site_id]
    add_column :comments, :site_id, :integer
    add_index :comments, [:site_id, :post_id]
    add_column :tags, :site_id, :integer
    add_index :tags, [:site_id, :name]
  end

  def self.down
    drop_table :sites
    remove_index :posts, :site_id
    rename_column :posts, :site_id, :blog_id
    remove_index :comments, [:site_id, :post_id]
    remove_column :comments, :site_id
    remove_index :tags, [:site_id, :name]
    remove_column :tags, :site_id
  end
end
