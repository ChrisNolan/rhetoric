class Post < ActiveRecord::Base
  acts_as_taggable
  by_site
  
  belongs_to :user
  has_many :comments, :dependent => :destroy, :order => 'created_at DESC'
  has_many :related_posts, :dependent => :destroy
  has_many :related, :through => :related_posts, :source => :related_post
  
  validates_presence_of :title
  validates_presence_of :body
  validates_uniqueness_of :imported_id, :on => :create, :allow_nil => true
  
  def to_s
    title
  end
  
  def rendered_body
    Markdown.new(body).to_html
  end
  
  def self.per_page
    Site.current.per_page || 15
  end
  
  def Post.headlines
    find_site :all, :order => 'published_at DESC', :limit => Site.current.headlines_limit if Site.current
  end
  
  #
  def Post.for_calendar
    records = find_site(
      :all,
      :select => "YEAR(published_at) as year, MONTH(published_at) as month, DAY(published_at) as day, COUNT(*) AS records",
      :group => "year, month, day")
    
  end
  
  # Import my old blog which I've exported to a custom csv file
  def Post.import(import_file)
    require 'fastercsv' # TODO make optional?
    puts "* #{import_file}"
    FasterCSV.foreach(import_file) do |row|
      imported_id = row[0]
      imported_body = imported_id.to_i > 1003 ? row[2].gsub('\n', "\n") : row[2].gsub('\n', "\n\n")
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
