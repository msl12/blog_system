class BlogController < ApplicationController

	def index
		  @blogs=Blog.order('id DESC').paginate(page: params[:page])
	end

	def show
		@blog=Blog.find(params[:id].to_i)
		@blog.increment_view_count
	end

end