require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/sites/index.html.erb" do
  include SitesHelper
  
  before(:each) do
    assigns[:sites] = [
      stub_model(Site,
        :url => "value for url",
        :title => "value for title",
        :description => "value for description",
        :keywords => "value for keywords",
        :per_page => "1",
        :headlines_max => "1",
        :headlines_title => "value for headlines_title"
      ),
      stub_model(Site,
        :url => "value for url",
        :title => "value for title",
        :description => "value for description",
        :keywords => "value for keywords",
        :per_page => "1",
        :headlines_max => "1",
        :headlines_title => "value for headlines_title"
      )
    ]
  end

  it "should render list of sites" do
    render "/sites/index.html.erb"
    response.should have_tag("tr>td", "value for url", 2)
    response.should have_tag("tr>td", "value for title", 2)
    response.should have_tag("tr>td", "value for description", 2)
    response.should have_tag("tr>td", "value for keywords", 2)
    response.should have_tag("tr>td", "1", 2)
    response.should have_tag("tr>td", "1", 2)
    response.should have_tag("tr>td", "value for headlines_title", 2)
  end
end

