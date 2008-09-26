ActiveRecord::Base.send(:extend, BySite::ActMethods)
# Markdown
require 'rdiscount' # To replace the *slow* BlueCloth
# otherwise set Markdown = BlueCloth
