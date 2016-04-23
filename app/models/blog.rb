class Blog < ActiveRecord::Base
	belongs_to :blog_content, :dependent => :destroy
	belongs_to :account
	delegate :content, :to => :blog_content, :allow_nil => true

	validates :title, :presence => true
	validates :title, :length => {:in => 3..50}

	 def content=(value)
	 	self.blog_content||=BlogContent.new
	 	self.blog_content.content=value

	 	self.blog_content.save
	 end

	 def increment_view_count
	 	increment(:view_count)        # add view_count += 1
	 	#write_second_level_cache      # update cache per hit, but do not touch db # update db per 10 hits
	 	#self.class.update_all({:view_count => view_count}, :id => id) if view_count % 10 == 0
	end

end