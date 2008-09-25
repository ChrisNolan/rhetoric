class CommentsController < ApplicationController
  
  make_resourceful do
    actions :all
    belongs_to [:post]
  end
  
  def current_objects
    @current_objects ||= current_model.paginate :order => 'created_at DESC', :page => params[:page]
  end
  
end
