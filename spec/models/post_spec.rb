require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Post do
  before(:each) do
    @valid_attributes = {
      :blog_id => "1",
      :title => "value for title",
      :body => "value for body",
      :published_at => Time.now,
      :user_id => "1"
    }
  end

  it "should create a new instance given valid attributes" do
    Post.create!(@valid_attributes)
  end
end
