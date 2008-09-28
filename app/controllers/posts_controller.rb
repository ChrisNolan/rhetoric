class PostsController < ApplicationController
  
  before_filter :login_required, :except => [:index, :show, :title_index, :date_index]
  
  make_resourceful do
    actions :all
    # publish :xml, :attributes => [:title, :rendered_body] # TODO this fails my tests, but the respond_to block below doesn't.  I think maybe it can handle the .xml, but not the request.env["HTTP_ACCEPT"] = "application/xml" ?
    
    response_for :index do |format|
      format.html
      format.xml {render :xml => current_objects.to_xml({
        :except => [:id, :site_id, :body, :user_id, :created_at, :updated_at],
        :methods => [:rendered_body, :to_param]
      })}
    end
    
    response_for :show do |format|
      format.html
      format.xml {render :xml => current_object.to_xml({
        :except => [:id, :site_id, :body, :user_id, :created_at, :updated_at],
        :methods => [:rendered_body, :to_param]
      })}
    end
    
  end
  
  def current_object
    if params[:id]
      @current_object ||= current_model.find_site (params[:id])
    else
      @current_object ||= current_model.new
    end
  end
  
  def current_objects
    @current_objects ||= Site.current.posts.paginate :page => params[:page], :order => 'published_at DESC'
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
    @posts = Site.current.posts.paginate :page => params[:page], :per_page => (per_page || 50), :order => 'published_at DESC'
  end
  
  def date_index
    unless params[:date].blank?
      case params[:date].length
      when 8
        starting_date = Date.parse params[:date]
        @date_range = starting_date.to_time...(starting_date + 1.day).to_time
      when 6
        starting_date = Date.parse params[:date]+'01'
        @date_range = starting_date.to_time...(starting_date + 1.month).to_time
      when 4
        starting_date = Date.parse params[:date]+'0101'
        @date_range = starting_date.to_time...(starting_date + 1.year).to_time
      else
        flash[:error] = 'Unsupported Date Format'
        redirect_to date_index_url(nil) && return
      end
      @page_title = "Posts Published #{@date_range.to_s(:date_archive)}"
      @posts = Site.current.posts.paginate :page => params[:page], :order => 'published_at', :conditions => {:published_at => @date_range}
    end
  end
  
end
