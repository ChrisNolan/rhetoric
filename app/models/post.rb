class Post < ActiveRecord::Base
  acts_as_taggable
  
  has_many :comments, :order => 'created_at DESC'
  
  validates_presence_of :title
  validates_presence_of :body
  
  
  def rendered_body
    Markdown.new(body).to_html
  end
  
end
