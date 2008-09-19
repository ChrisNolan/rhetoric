require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/posts/index.html.erb" do
  include PostsHelper
  
  before(:each) do
    @published_at_1 = Time.now - 5.days
    @published_at_2 = Time.now - 12.days
    assigns[:posts] = [
      stub_model(Post,
        :title => "value for title",
        :body => "value for body",
        :published_at => @published_at_1
      ),
      stub_model(Post,
        :title => "value for title",
        :body => "value for body",
        :published_at => @published_at_2
      )
    ]
  end

  it "should render list of posts" do
    render "/posts/index.html.erb"
    response.should have_tag("li>h2", /value for title/, 2)
    response.should have_tag("li>p", 'value for body', 2)
    response.should have_tag("li>div.published_at") #, :text => @published_at_1) # TODO time-zone stuff?
    response.should have_tag("li>div.published_at") #, :text => @published_at_2)
  end
  
end