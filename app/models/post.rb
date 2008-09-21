class Post < ActiveRecord::Base
  acts_as_taggable
  
  has_many :comments, :order => 'created_at DESC'
  has_many :related_posts
  has_many :related, :through => :related_posts, :source => :related_post
  
  validates_presence_of :title
  validates_presence_of :body
  
  def to_s
    title
  end
  
  def rendered_body
    Markdown.new(body).to_html
  end
  
end
