class BlogComment < ActiveRecord::Base
	acts_as_cached
	validates_presence_of :content
	belongs_to :blog, :counter_cache => :comments_count
	belongs_to :account, :counter_cache => :comments_count

	after_save :clean_cache
	before_destroy :clean_cache

	def clean_cache
		Rails.cache.delete("#{CACHE_PREFIX}/layout/right")
	end

	def md_content
		Rails.cache.fetch(content_cache_key) do
			Sanitize(GitHub::Markdown.to_html(content, :gfm))
		end
	end

	def content_cache_key
		"#{CACHE_PREFIX}/comment_content/#{self.id}"
	end
  
end