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

  def Comment.import(import_file)
    require 'fastercsv' # TODO make optional?
    puts "* #{import_file}"
    FasterCSV.foreach(import_file) do |row|
      post = Post.find_by_imported_id row[0]
      comment = post.comments.new :title => row[2], :body => row[3], :created_at => Time.parse(row[4]), :author => row[5], :author_email => (row[7] || 'dev@null.com'), :author_url => row[6]
      if comment.save
        puts "Imported Comment #{comment.display_title} for post #{post.id}"
      else
        puts "** Error importing #{row[0] + row[1]} / #{comment.errors.full_messages.join('; ')}"
      end
    end
  end
  
end
