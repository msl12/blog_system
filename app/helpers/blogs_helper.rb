module BlogsHelper

	def markdown(content)
		sanitize(GitHub::Markdown.render(content))
	end

	def commenter_logo(commenter)
		if commenter.provider && commenter.provider == 'qq'
			link_to image_tag(commenter.profile_image_url, :alt => commenter.name), commenter.profile_url, :target => '_blank', :rel => 'nofollow'
		else
	      		link_to image_tag('website.jpg', :alt => commenter.name), APP_CONFIG['site_url']
	      	end
	end

	def commenter_link(commenter)
		if commenter.provider && commenter.provider == 'qq'
			link_to commenter.name, commenter.profile_url, :target => '_blank', :rel => 'nofollow'
		else
			link_to commenter.name, APP_CONFIG['site_url']
		end
	end

	def brief_content(content)
		sanitize(content).truncate(100)
	end

end