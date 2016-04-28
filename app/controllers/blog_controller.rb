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

	def create_comment
		return false unless account_login?
		blog = Blog.find(params[:id])
		@comment = blog.comments.new
		@comment.account = current_account
		@comment.content = blog_comment_params[:content]
		@comment.save
		#render 'blog/create_comment' # JS不晓得为什么用不了
		redirect_to blog_path(blog) # 为什么不能实现跳转？
	end

	def comment # 无力吐槽...
		comment = BlogComment.find(params[:id])
		if account_admin?
			comment.destroy
		else
			halt_403
		end
	end

	private
	def blog_comment_params
		params.require(:blog_comment).permit(:content)
	end

end