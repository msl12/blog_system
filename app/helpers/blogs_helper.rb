module BlogsHelper

	def commenter_logo(commenter)
		if commenter.provider && commenter.provider == 'qq' && commenter.profile_url
			link_to image_tag(commenter.profile_image_url, :alt => commenter.name), commenter.profile_url, :target => '_blank', :rel => 'nofollow'
		elsif commenter.provider && commenter.provider == 'qq' && commenter.profile_url.nil?
			image_tag(commenter.profile_image_url, :alt => commenter.name)
		else
	      		link_to image_tag('website.jpg', :alt => commenter.name), APP_CONFIG['site_url']
	      	end
	end

	def commenter_link(commenter)
		if commenter.provider && commenter.provider == 'qq' && commenter.profile_url
			link_to commenter.name, commenter.profile_url, :target => '_blank', :rel => 'nofollow'
		elsif commenter.provider && commenter.provider == 'qq' && commenter.profile_url.nil?
			"#{commenter.name}"
		else
			link_to commenter.name, APP_CONFIG['site_url']
		end
	end

end