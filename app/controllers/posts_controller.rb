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
    @current_objects ||= current_model.paginate :page => params[:page], :order => 'published_at DESC'
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
  
  def title_index
    if params[:page] == 'all'
      params[:page] = 1
      per_page = 2500
    end
    @posts = Post.paginate :page => params[:page], :per_page => (per_page || 50), :order => 'published_at DESC'
  end
  
  def date_index
    case params[:date].length
    when 8
      @posted_date = Date.parse params[:date]
      @date_range = @posted_date.to_time...(@posted_date + 1.day).to_time
    end
    @posts = Post.paginate :page => params[:page], :order => 'published_at', :conditions => {:published_at => @date_range}
  end
  
end
