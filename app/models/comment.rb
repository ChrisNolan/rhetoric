class Comment < ActiveRecord::Base
  
  belongs_to :post, :counter_cache => true
  
  validates_presence_of :post_id, :body, :author, :author_email
  
  def display_title
    if title.blank?
      post.title
    else
      post.title + " :: " + title
    end
  end
  
  def linked_author
    if author_url.blank?
      author
    else
      "<a href=\"#{author_url}\" rel=\"nofollow\">#{author}</a>"
    end
  end
  
end
