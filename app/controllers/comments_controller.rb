class CommentsController < ApplicationController
  
  make_resourceful do
    actions :all
    belongs_to [:post]
  end
  
  def current_object
    if params[:id]
      @current_object ||= current_model.find_site (params[:id])
    else
      @current_object ||= current_model.new
    end
  end
  
  def current_objects
    @current_objects ||= Site.current.comments.paginate :order => 'created_at DESC', :page => params[:page]
  end
  
end
