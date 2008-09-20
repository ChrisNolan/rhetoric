class CommentsController < ApplicationController
  
  make_resourceful do
    actions :all
    belongs_to [:post]
  end
  
end
