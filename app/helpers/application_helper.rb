# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def page_title
    base_title = Site.current && Site.current.page_title
    "#{base_title} #{" : #{page_sub_title}" unless page_sub_title.blank?}"
  end
  
  def page_sub_title
    sub_title = @page_title if @page_title
    sub_title = @post.title if @post
    unless sub_title
      sub_title = action_name  unless action_name == 'index'
      sub_title = controller.class.to_s.sub(/Controller/, '') if action_name == 'index' && controller.class.to_s != 'PostsController'
    end
    sub_title
  end
  
  def archive_footer
    link_to 'Archive', archive_path
  end
  
end
