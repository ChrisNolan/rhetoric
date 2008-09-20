class Post < ActiveRecord::Base
  
  has_many :comments
  
  validates_presence_of :title
  validates_presence_of :body
  
  
  def rendered_body
    Markdown.new(body).to_html
  end
  
end
