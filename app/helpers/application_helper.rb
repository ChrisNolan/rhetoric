# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def archive_footer
    link_to 'Archive', archive_path
  end
  
end
