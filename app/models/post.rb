require 'uri'
class Post < ActiveRecord::Base
  # Dummy url
  URL = "localhost:3000/"
   
  before_save :update_permalink
   
  validates_uniqueness_of :permalink
   
  def update_permalink
    if URL =~ URI::regexp
      self.permalink = (URL+title.tr!(' ', '-'))
    end
  end
   
  Post.all.find_each do |post|
    post.update_permalink
    post.save
  end
end