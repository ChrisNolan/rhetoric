## lifted from http://railspikes.com/2008/3/1/cleaner-code-with-conversions

# Formats the time using strftime.
# Example: Time.now.to_s(:date_archive) #=> "03:23PM" 

#ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.update(:date_archive => '%Y %B %D')

# Formats the date using a lambda.
# Example: Date.today.to_s(:date_archive) #=> "February 29th"

date_formats = {
  :date_archive => lambda { |date| date.strftime("%B #{date.day.ordinalize}, %Y") }
}
ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.update(date_formats)
ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS.update(date_formats)
# DateTime uses Time's DATE_FORMATS, so there's nothing to update for it.

# Examples: 
# (1.day.ago..5.days.from_now).to_s(:date_archive) #=> "February 28th to March 5th"

range_formats = { :date_archive => lambda do |start, stop| 
                              [ start.to_s(:date_archive), stop.to_s(:date_archive) ].join(" to ") 
                            end }
ActiveSupport::CoreExtensions::Range::Conversions::RANGE_FORMATS.update(range_formats)
