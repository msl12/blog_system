class BlogComment < ActiveRecord::Base
	 validates_presence_of :content
	 belongs_to :blog, :counter_cache => :comments_count
	 belongs_to :account, :counter_cache => :comments_count
end