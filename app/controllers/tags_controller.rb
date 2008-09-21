class TagsController < ApplicationController
  def index
    @tags = Post.tag_counts
  end

  def show
    @tag = Tag.find_by_name params[:name]
  end

end
