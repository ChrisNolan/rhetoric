class Site < ActiveRecord::Base
  cattr_accessor :current
  has_many :posts
  has_many :comments
  
  validates_presence_of :url
  validates_presence_of :title
end
