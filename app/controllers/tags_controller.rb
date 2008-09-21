class TagsController < ApplicationController
  def index
    @tags = Post.tag_counts
  end

  def show
    @tag = Tag.find_by_name params[:name]
  end
  
  def add
    @post = Post.find params[:id] # TODO make this more 'taggable' so it could tag more than one class
    @post.tag_list.add params[:new_tags].split(',')
    @post.save
  end

end
