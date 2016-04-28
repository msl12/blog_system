class AdminsController < ApplicationController
	before_action :check_admin?

	def new_blog
		@blog=Blog.new
	end

	def blog
		@blog=Blog.new(blog_params)
		@blog.account=current_account
		if @blog.save
			flash[:notice] = '文章成功发布'
			redirect_to blog_path(@blog)
		else
			render 'new_blog'
		end
	end

	def destroy
		@blog=Blog.find(params[:id].to_i)
		@blog.destroy
		flash[:notice]='文章已经删除'
		redirect_to '/'
	end

	def edit
		  @blog=Blog.find(params[:id].to_i)
		  if @blog.update_blog(blog_params)
		  	flash[:notice]='文章修改完成'
		  	redirect_to blog_path(@blog)
		  else
		  	render 'edit_blog'
		  end
	end

	def edit_blog
		@blog=Blog.find(params[:id].to_i)
	end

  	def blog_preview
  		GitHub::Markdown.render(params[:term], :gfm) if params[:term]
  	end

	private
	def blog_params
		params.require(:blog).permit(:title, :content, :user_tags)
	end

	def check_admin?
		halt_403 unless account_admin?
	end

end