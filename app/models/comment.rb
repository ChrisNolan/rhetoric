class Comment < ActiveRecord::Base
  
  belongs_to :post, :counter_cache => true
  
  validates_presence_of :post_id, :body, :author, :author_email
  
end
