class AdminsController < ApplicationController
	def new_blog
		@blog=Blog.new
	end

	def blog
		@blog=Blog.new(blog_params)
		@blog.account=current_account
		#@blog.user_id=current_account.id
		if @blog.save
			#@blog.user_id=current_account.id
			#ping_search_engine(@blog) if APP_CONFIG['blog_search_ping'] # only ping search engine in production environment
			flash[:notice] = '文章成功发布'
			redirect_to blog_path(@blog)
		else
			render 'new_blog'
		end
	end

	private
	def blog_params
		params.require(:blog).permit(:title, :content)
	end

end