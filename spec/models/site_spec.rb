require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Site do
  before(:each) do
    @valid_attributes = {
      :user_id => "1",
      :url => "value for url",
      :title => "value for title",
      :description => "value for description",
      :keywords => "value for keywords",
      :per_page => "1",
      :headlines_max => "1",
      :headlines_title => "value for headlines_title"
    }
  end

  it "should create a new instance given valid attributes" do
    Site.create!(@valid_attributes)
  end
end
