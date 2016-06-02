class BlogComment < ActiveRecord::Base
	acts_as_cached
	validates_presence_of :content
	belongs_to :blog, :counter_cache => :comments_count
	belongs_to :account, :counter_cache => :comments_count

	def md_content
		Rails.cache.fetch(content_cache_key) do
			Sanitize.clean(GitHub::Markdown.to_html(content, :gfm), Sanitize::Config::RELAXED)
		end
	end

	def brief_content
		Sanitize.clean(content).truncate(100)
	end

	def content_cache_key
		"#{CACHE_PREFIX}/comment_content/#{self.id}"
	end
  
end