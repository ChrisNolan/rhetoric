require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module PostSpecHelper
  
  def valid_post_attributes
    {
      :blog_id => "1",
      :title => "value for title",
      :body => "value for body",
      :published_at => Time.now,
      :user_id => "1"
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
  
end
