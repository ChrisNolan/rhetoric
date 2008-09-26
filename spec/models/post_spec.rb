require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module PostSpecHelper
  
  def valid_post_attributes
    {
      :site_id => "1",
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

describe Post do
  
  include Matchers::ActiveRecordMatchers
  include PostSpecHelper
  
  before(:each) do
    @post = Post.new valid_post_attributes
  end
  
  it "should create a new instance given valid attributes" do
    Post.create!(valid_post_attributes)
  end
  
  it 'should require a title' do
    @post.title = nil
    @post.should have_error_on(:title, :blank)
  end
  
  it 'should require a body' do
    @post.body = nil
    @post.should have_error_on(:body, :blank)
  end
  
  it 'should have many comments' do
    @post.save
    lambda {
      @post.comments << Comment.new(valid_comment_attributes)
    }.should change(Comment, :count)
    lambda {
      @post.comments << Comment.new(valid_comment_attributes)
    }.should change(Comment, :count)
    @post.reload # why is the reload necessary for the counter_cache to be populated?
    @post.comments_count.should == 2
  end
  
  it 'should have a rendered_body' do
    @post.rendered_body.should_not be_blank
  end
  
end
