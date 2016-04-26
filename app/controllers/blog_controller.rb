class BlogController < ApplicationController

	def index
		  @blogs=Blog.order('id DESC').paginate(page: params[:page])
	end

	def show
		@blog=Blog.find(params[:id].to_i)
		@blog.increment_view_count
	end

	def tag
		@blogs = Blog.tagged_with(params[:name]).order('id DESC').paginate(page: params[:page])
		if @blogs.blank?
			halt_404
		else

		end
	end

	def tag_cloud

	end

end