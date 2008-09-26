require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/sites/show.html.erb" do
  include SitesHelper
  
  before(:each) do
    assigns[:site] = @site = stub_model(Site,
      :url => "value for url",
      :title => "value for title",
      :description => "value for description",
      :keywords => "value for keywords",
      :per_page => "1",
      :headlines_max => "1",
      :headlines_title => "value for headlines_title"
    )
  end

  it "should render attributes in <p>" do
    render "/sites/show.html.erb"
    response.should have_text(/value\ for\ url/)
    response.should have_text(/value\ for\ title/)
    response.should have_text(/value\ for\ description/)
    response.should have_text(/value\ for\ keywords/)
    response.should have_text(/1/)
    response.should have_text(/1/)
    response.should have_text(/value\ for\ headlines_title/)
  end
end

