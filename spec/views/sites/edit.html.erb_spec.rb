require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/sites/edit.html.erb" do
  include SitesHelper
  
  before(:each) do
    assigns[:site] = @site = stub_model(Site,
      :new_record? => false,
      :url => "value for url",
      :title => "value for title",
      :description => "value for description",
      :keywords => "value for keywords",
      :per_page => "1",
      :headlines_max => "1",
      :headlines_title => "value for headlines_title"
    )
  end

  it "should render edit form" do
    render "/sites/edit.html.erb"
    
    response.should have_tag("form[action=#{site_path(@site)}][method=post]") do
      with_tag('input#site_url[name=?]', "site[url]")
      with_tag('input#site_title[name=?]', "site[title]")
      with_tag('textarea#site_description[name=?]', "site[description]")
      with_tag('input#site_keywords[name=?]', "site[keywords]")
      with_tag('input#site_per_page[name=?]', "site[per_page]")
      with_tag('input#site_headlines_max[name=?]', "site[headlines_max]")
      with_tag('input#site_headlines_title[name=?]', "site[headlines_title]")
    end
  end
end


