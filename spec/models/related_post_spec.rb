require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
module RelatedPostSpecHelper
  
  def valid_related_post_attributes
    {
      :post_id => 1,
      :related_post_id => 2
    }
  end
  
end

describe Post do
  
  include Matchers::ActiveRecordMatchers
  include RelatedPostSpecHelper
  
  before(:each) do
    @post_1 = Post.create :title => "Test Post 1", :body => "Yo, yo"
    @post_2 = Post.create :title => "Test Post 2", :body => "Ho, ho"
    @post_3 = Post.create :title => "Test Post 3", :body => "So, so?"
    @related_post = RelatedPost.new valid_related_post_attributes
  end

  it 'should require post_id' do
    @related_post.post_id = nil
    @related_post.should have_error_on(:post_id, :blank)
  end
  
  it 'should require related_post_id' do
    @related_post.related_post_id = nil
    @related_post.should have_error_on(:related_post_id, :blank)
  end
  
  it 'should have unique related_post_id per post' do
    @post_1.related_posts.create :related_post => @post_2
    duplicate = @post_1.related_posts.new :related_post => @post_2
    duplicate.should have_error_on(:related_post_id, :taken)
  end
  
  it 'should not be related to itself' do
    duplicate = @post_1.related_posts.new :related_post => @post_1
    duplicate.should have_error_on(:related_post_id, :blank)
  end
  
  it 'should handle the reverse relationship automatically' do
    @post_1.related << @post_2
    @post_2.reload
    @post_2.related.should be_include(@post_1)
  end
  
end
