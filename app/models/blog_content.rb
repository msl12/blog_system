class BlogContent < ActiveRecord::Base
	validates :content, :presence => true
end