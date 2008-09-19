class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :post_id
      t.string :title
      t.text :body
      t.string :author, :limit => 64
      t.string :author_url
      t.string :author_email
      t.string :author_ip, :limit => 64

      t.timestamps
    end
    
    add_index :comments, :post_id
    
    add_column :posts, :comments_count, :integer, :default => 0
  end

  def self.down
    drop_table :comments
    remove_column :posts, :comments_count
  end
end
