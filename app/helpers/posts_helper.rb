module PostsHelper
  
  # TODO there has to be some nice ruby block/iterator kind of thing to clean this up...
  def date_index_calendar
    html = '<ul>'
    daily_posts = Post.for_calendar
    for year in daily_posts.first.year..daily_posts.last.year
      daily_posts_per_year = daily_posts.select{|daily|daily.year == year}
      unless daily_posts_per_year.empty?
        html << '<ul class="years">'
        html << "<li>#{link_to year, date_index_path(year)}</li>\n"
        for month in 1..12
          daily_posts_per_month = daily_posts_per_year.select{|daily|daily.month == month.to_s}
          unless daily_posts_per_month.empty?
            html << '<ul class="months">'
            html << "<li>#{link_to month, date_index_path(year + sprintf('%.2d', month))}</li>\n"
            html << '<ul class="days">'
            for posted_day in daily_posts_per_month
              day_of_month = Date.parse "#{posted_day.year}-#{posted_day.month}-#{posted_day.day}"
              html << "<li>#{link_to day_of_month.to_s(:short), date_index_path(day_of_month.to_s(:number)), :title => pluralize(posted_day.records, 'post')}</li>\n"
            end
            html << '</ul>'
            html << '</ul>'
          end
        end
        html << '</ul>'
      end
    end
    html << '</ul>'
  end
  
  def sidebar_headlines
    render :partial => 'posts/headlines', :locals => {:posts => Post.headlines}
  end
  
end
