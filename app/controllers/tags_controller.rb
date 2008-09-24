class TagsController < ApplicationController
  def index
    @tags = Post.tag_counts :order => :name
  end

  def show
    @tag = Tag.find_by_name params[:name]
    find_options = {:order => "posts.published_at #{' DESC' if params[:sort_order] == 'D'}", :include => :tags}
    find_options.merge! :page => params[:page] unless params[:page] == 'all'
    @posts = Post.send("#{params[:page] == 'all' ? 'find' : 'paginate'}_tagged_with", @tag, find_options)
    @related_tags = Post.find_related_tags @tag
  end
  
  def add
    @post = Post.find params[:id] # TODO make this more 'taggable' so it could tag more than one class
    unless params[:new_tags].blank?
      @post.tag_list.add params[:new_tags].split(',')
      @post.save
    else
      flash.now[:error] = 'No tags inputted'
    end
  end

end
