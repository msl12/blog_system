class Blog < ActiveRecord::Base
	acts_as_cached version: 1, expires_in: 1.week
	acts_as_taggable

	after_save :clean_cache
	before_destroy :clean_cache

	has_many :comments, :class_name => 'BlogComment', :dependent => :destroy
	has_many :attachments, :dependent => :destroy
	belongs_to :blog_content, :dependent => :destroy
	belongs_to :account
	delegate :content, :to => :blog_content, :allow_nil => true

	validates :title, :presence => true
	validates :title, :length => {:in => 3..50}

	def user_tags
		self.tag_list.join(" , ")
	end

	 def content=(value)
	 	self.blog_content ||= BlogContent.new
	 	self.blog_content.content = value
	 	self.blog_content.save
	 end

	 def increment_view_count
	 	increment(:view_count)
	 	write_second_level_cache
	 	update_attribute(:view_count, view_count) if view_count % 10 == 0
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

	def self.cached_tag_cloud
		Rails.cache.fetch("#{CACHE_PREFIX}/blog_tags/tag_cloud") do
			self.tag_counts.sort_by(&:count).reverse
		end
	end

	def user_tags
		self.tag_list.join(" , ")
	end

	def user_tags=(tags)
		unless tags.blank?
			self.tag_list = tags.split(/\s*,\s*/).uniq.collect {|t| t.downcase}.select {|t| t =~ /^(?!_)(?!.*?_$)[\+#a-zA-Z0-9_\s\u4e00-\u9fa5]+$/}.join(",")
		end
	end

	def cached_tags
		cached_tag_list ? cached_tag_list.split(/\s*,\s*/) : []
	end

	def attach!(owner)
		self.transaction do
			owner.attachments.orphan.each {|attachment| attachment.update_attribute(:blog_id, self.id) }
		end
	end

	def clean_cache
		Rails.cache.delete("#{CACHE_PREFIX}/blog_tags/tag_cloud")
  	end

  	def md_content
  		Rails.cache.fetch(content_cache_key) do
  			GitHub::Markdown.to_html(content, :gfm)
  		end
  	end

  	def content_cache_key
  		"#{CACHE_PREFIX}/blog_content/#{self.id}/#{updated_at.to_i}"
  	end

end