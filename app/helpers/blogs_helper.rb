module BlogsHelper

	def markdown(content)
		raw(GitHub::Markdown.render(content))
	end

end