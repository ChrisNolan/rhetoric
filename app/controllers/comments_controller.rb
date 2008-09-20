class CommentsController < ApplicationController
  
  make_resourceful do
    actions :all
    belongs_to [:post]
  end
  
  def current_objects
    @current_objects ||= current_model.find :all, :order => 'created_at DESC'
  end
  
end
