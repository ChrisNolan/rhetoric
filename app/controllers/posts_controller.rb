class PostsController < ApplicationController
  make_resourceful do
    actions :all
    # publish :xml, :attributes => [:title, :rendered_body] # TODO this fails my tests, but the respond_to block below doesn't.  I think maybe it can handle the .xml, but not the request.env["HTTP_ACCEPT"] = "application/xml" ?
    
    response_for :index do |format|
      format.html
      format.xml {render :xml => current_objects.to_xml({
        :except => [:id, :blog_id, :body, :user_id, :created_at, :updated_at],
        :methods => [:rendered_body, :to_param]
      })}
    end
    
    response_for :show do |format|
      format.html
      format.xml {render :xml => current_object.to_xml({
        :except => [:id, :blog_id, :body, :user_id, :created_at, :updated_at],
        :methods => [:rendered_body, :to_param]
      })}
    end
    
  end
  
  def current_objects
    @current_objects ||= current_model.find :all, :order => 'published_at DESC'
  end
  
  def add_related
    @post = Post.find params[:id]
    @related = Post.find params[:related_post] rescue nil
    if @related
      @post.related << @related rescue flash.now[:error] = 'Already Related'
    else
      flash.now[:error] = "Please Select a Valid Post"
    end
  end
  
end
