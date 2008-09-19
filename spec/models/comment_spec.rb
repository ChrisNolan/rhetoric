require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module CommentSpecHelper
  
  def valid_post_attributes
    {
      :blog_id => "1",
      :title => "value for title",
      :body => "value for body",
      :published_at => Time.now,
      :user_id => "1"
    }
  end
  
  def valid_comment_attributes
    {
      :title => "value for title",
      :body => "value for body",
      :author => "value for author",
      :author_url => "value for author_url",
      :author_email => "value for author_email",
      :author_ip => "value for author_ip"
    }
  end
  
end

describe Comment do
  include Matchers::ActiveRecordMatchers
  include CommentSpecHelper
  
  before(:all) do
    @post = Post.create valid_post_attributes
  end
  
  before(:each) do
    @comment = @post.comments.new valid_comment_attributes
  end
  
  it "should create a new instance given valid attributes" do
    @post.comments.create!(valid_comment_attributes)
  end
  
  it 'should require a post_id' do
    @comment.post_id = nil
    @comment.should have_error_on(:post_id, :blank)
  end
  
  it 'should require a body' do
    @comment.body = nil
    @comment.should have_error_on(:body, :blank)
  end
  
  it 'should require a author' do
    @comment.author = nil
    @comment.should have_error_on(:author, :blank)
  end
  
  it 'should require a author_email' do
    @comment.author_email = nil
    @comment.should have_error_on(:author_email, :blank)
  end
  
  it 'should test author_email is valid email'
  
  it 'should test author_url is valid url if present'
  
  it 'should belong to a post' do
    @comment.post.should be_kind_of(Post)
  end
  
end
