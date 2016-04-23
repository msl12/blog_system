class BlogController < ApplicationController

	def show
		@blog=Blog.find(params[:id].to_i)
		@blog.increment_view_count
	end

end