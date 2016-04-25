class HomeController < ApplicationController
	before_action :already_logged?, only: [:login_get, :login_post]

	def index
		@blogs=Blog.order('id DESC').paginate(page: params[:page])
	end

	def login_get
		@account=Account.new
	end

	def login_post
		@account=Account.new(account_params)
		if login_account=Account.authenticate(@account.email, @account.password)
			session[:account_id]=login_account.id
			flash[:notice]='成功登录'
			redirect_to '/'
		else
			render 'login_get'
		end
	end

	def logout
		if account_login?
			session[:account_id]=nil
			# @current_account=nil # 是否需要？
		end
		redirect_to '/'
	end

	private
	def account_params
		params.require(:account).permit(:email, :password)
	end

	def already_logged?
		 redirect_to '/' if account_login?
	end

end