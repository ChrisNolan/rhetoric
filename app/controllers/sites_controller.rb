class SitesController < ApplicationController
  
  before_filter :login_required
  
  make_resourceful do
    actions :all
  end
end
