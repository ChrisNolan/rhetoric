module PostsHelper
  
  def date_index_calendar
    html = '<ul>'
    for r in Post.for_calendar
      day = Date.parse "#{r.year}-#{r.month}-#{r.day}"
      html << "<li>#{link_to day, date_index_path(day.to_s(:number))}: #{r.records}</li>"
    end
    html << '</ul>'
  end
  
end
