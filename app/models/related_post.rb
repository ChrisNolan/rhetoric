class RelatedPost < ActiveRecord::Base
  validates_presence_of :post_id
  validates_presence_of :related_post_id
  validates_uniqueness_of :post_id, :on => :create, :scope => :related_post_id
  validates_uniqueness_of :related_post_id, :on => :create, :scope => :post_id
  
  belongs_to :post
  belongs_to :related_post, :class_name => 'Post', :foreign_key => :related_post_id
  
  def before_validation
    self.related_post = nil if related_post == post
  end
  
  def after_create
    related_post.related_posts.create :related_post => post
  end
  
end
