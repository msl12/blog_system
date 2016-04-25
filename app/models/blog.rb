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
	 	increment(:view_count)
	 	self.save
	end

	def self.hot_blogs(count)
		self.order('view_count DESC').limit(count)
	end

	def update_blog(param_hash)
		self.transaction do
			update_attributes!(param_hash)
			blog_content.save!
			save!
		end
	rescue
		return false
	end

end