class CreateRelatedPosts < ActiveRecord::Migration
  def self.up
    create_table :related_posts do |t|
      t.belongs_to :post, :related_post
    end
    add_index :related_posts, :post_id
    add_index :related_posts, :related_post_id
  end

  def self.down
    drop_table :related_posts
  end
end
