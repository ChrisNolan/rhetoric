class Site < ActiveRecord::Base
  cattr_accessor :current
  has_many :posts
  has_many :comments
  
  validates_presence_of :url
  validates_presence_of :title
  
  def page_title
    title || 'please configure your rhetoric site title'
  end
  
  def headlines_limit
    headlines_max || 15
  end
  
  def display_headlines_title
    headlines_title.blank? ? 'Recent Posts' : headlines_title
  end
  
end
