class Post < ActiveRecord::Base
  acts_as_taggable
  
  has_many :comments, :dependent => :destroy, :order => 'created_at DESC'
  has_many :related_posts, :dependent => :destroy
  has_many :related, :through => :related_posts, :source => :related_post
  
  validates_presence_of :title
  validates_presence_of :body
  validates_uniqueness_of :imported_id, :on => :create
  
  def to_s
    title
  end
  
  def rendered_body
    Markdown.new(body).to_html
  end
  
  def self.per_page
    15
  end
  
  # Import my old blog which I've exported to a custom csv file
  def Post.import(import_file)
    require 'fastercsv' # TODO make optional?
    puts "* #{import_file}"
    FasterCSV.foreach(import_file) do |row|
      imported_id = row[0]
      imported_body = imported_id.to_i > 1003 ? row[2] : row[2].gsub('\n', "\n\n")
      post = Post.new :imported_id => imported_id, :title => row[1], :body => imported_body, :published_at => Time.parse(row[3])
      post.tag_list = row[4]
      if post.save
        puts "Imported #{post.imported_id} as #{post.id}"
      else
        puts "** Error importing #{post.imported_id} / #{post.errors.full_messages.join('; ')}"
      end
    end
  end
  
end
