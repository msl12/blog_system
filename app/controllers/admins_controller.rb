class AdminsController < ApplicationController
	def new_blog
		@blog=Blog.new
	end

	def blog
		@blog=Blog.new(blog_params)
		@blog.account=current_account
		if @blog.save
			@blog.attach!(current_account)
			#ping_search_engine(@blog) if APP_CONFIG['blog_search_ping'] # only ping search engine in production environment
			flash[:notice] = '文章成功发布'
			redirect_to url(:blog, :show, :id => @blog.id)
		else
			render 'new_blog'
		end
	end
	post :blog, :map => '/admin/blog' do
    @blog = Blog.new(params[:blog])
    @blog.account = current_account
    if @blog.save
      @blog.attach!(current_account)
      ping_search_engine(@blog) if APP_CONFIG['blog_search_ping'] # only ping search engine in production environment
      flash[:notice] = '文章成功发布'
      redirect url(:blog, :show, :id => @blog.id)
    else
      render 'admin/new_blog'
    end
  end

end