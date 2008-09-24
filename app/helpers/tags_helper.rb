module TagsHelper
  def top_20_tags
    render :partial => 'cloud', :locals => {:tags => Post.tag_counts(:order => 'count DESC, tags.name', :limit => 20).sort_by(&:name) }
  end
  
  # See the README for an example using tag_cloud.
  def tag_cloud(tags, classes)
    return if tags.empty?
    
    max_count = tags.sort_by(&:count).last.count.to_f
    
    tags.each do |tag|
      index = ((tag.count / max_count) * (classes.size - 1)).round
      yield tag, classes[index]
    end
  end
end
