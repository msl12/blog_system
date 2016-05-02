class AdminsController < ApplicationController
	before_action :check_admin?

	def new_blog
		@blog = Blog.new
		@attachments = current_account.attachments.orphan
	end

	def blog
		@blog = Blog.new(blog_params)
		@blog.account = current_account
		if @blog.save
			@blog.attach!(current_account)
			flash[:notice] = '文章成功发布'
			redirect_to blog_path(@blog)
		else
			render 'new_blog'
		end
	end

	def destroy
		@blog = Blog.find(params[:id].to_i)
		@blog.destroy
		flash[:notice] = '文章已经删除'
		redirect_to '/'
	end

	def edit
		  @blog = Blog.find(params[:id].to_i)
		  if @blog.update_blog(blog_params)
		  	@blog.attach!(current_account)
		  	flash[:notice] = '文章修改完成'
		  	redirect_to blog_path(@blog)
		  else
		  	render 'edit_blog'
		  end
	end

	def edit_blog
		@blog = Blog.find(params[:id].to_i)
		@attachments = current_account.attachments.where(:blog_id => [nil, @blog.id]).order('id ASC')
	end

  	def blog_preview
  		@preview = GitHub::Markdown.to_html(params[:term], :gfm) if params[:term]
  		render partial: 'blog_preview'
  	end

  	def new_attachment
  		render 'new_attachment', :layout => false
  	end

  	def attachment
  		@attachment = Attachment.find(params[:id])
  		render 'attachment', :layout => false
  	end

  	def create_attachment
  		attachment = Attachment.new(attachment_params)
  		attachment.account = current_account
  		if attachment.save
  			redirect_to attachment_path(attachment)
  		else
  			render 'attachment_fail', :layout => false
  		end
  	end

  	def delete_attachment
  		@attachment = Attachment.find(params[:id])
  		@attachment.destroy
  		render "delete_attachment"
  	end

	private
	def blog_params
		params.require(:blog).permit(:title, :content, :user_tags)
	end

	def attachment_params
		params.require(:attachment).permit(:file)
	end

	def check_admin?
		halt_403 unless account_admin?
	end

end