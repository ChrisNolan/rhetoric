# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  include AuthenticatedSystem

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '91cf76afc30cd541ff53788e80ddeda6'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  filter_parameter_logging :password
  
  before_filter do |c|
    Site.current = nil
    Site.current = Site.find_by_url c.request.env['HTTP_HOST']
    # you can over-ride any of the views by adding them to the extra view_path
    #  e.g. adding a apps/views/yoursite.com/layouts/application.html.erb it'll be rendered instead of the base.
    c.prepend_view_path RAILS_ROOT + "/app/views/#{Site.current.url}"
  end
  
end
