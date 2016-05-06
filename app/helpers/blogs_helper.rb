module BlogsHelper

	def markdown(content)
		sanitize(GitHub::Markdown.render(content))
	end

	def commenter_logo(commenter)
	      	link_to image_tag('website.jpg', :alt => commenter.name), APP_CONFIG['site_url']
	end

	def commenter_link(commenter)
		link_to commenter.name, APP_CONFIG['site_url']
	end

	def brief_content(content)
		sanitize(content).truncate(100)
	end

end