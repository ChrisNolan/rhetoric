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
  
  # Import my old blog which I've exported to a custom csv file
  def RelatedPost.import(import_file)
    require 'fastercsv' # TODO make optional?
    puts "* #{import_file}"
    FasterCSV.foreach(import_file) do |row|
      post = Post.find_by_imported_id row[0] rescue nil
      if post
        begin
          post.related << Post.find_by_imported_id(row[1])
          puts "Imported #{post.imported_id} as #{post.id}"
        rescue => e
          puts "** Error importing #{post.imported_id} <-> #{row[1]} / #{e}"
        end
      else
        puts "** #{row[0]} not yet imported"
      end
    end
  end
  
end
