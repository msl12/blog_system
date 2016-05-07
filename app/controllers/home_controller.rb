class HomeController < ApplicationController
	before_action :already_logged?, only: [:login_get, :login_post, :qq_callback, :qq_login]

	def index
		@blogs = Blog.order('id DESC').paginate(page: params[:page])
	end

	def login_get
		
	end

	def qq_login
		redirect_to QQAuth.new.authorize_url
	end

	def qq_callback
		return halt_401 unless params[:code]
		auth = QQAuth.new
		begin
			openid = auth.callback(params[:code])
			user_info = auth.get_user_info
			@account = Account.where(:provider => 'qq', :openid => openid).first
			unless @account 
				@account = Account.create(:provider => 'qq', :openid => openid, :name => user_info['nickname'], :profile_image_url => user_info['figureurl_qq_1'])
			end
			if @account.profile_image_url.blank?
				@account.update_attributes(:profile_image_url => user_info['profile_image_url'])
			end
			session[:account_id] = @account.id
			flash[:notice] = '成功登录'
			redirect_to '/'
		rescue => e
			return halt_401
		end
	end

	def login_post
		@account = Account.new(account_params)
		if login_account = Account.authenticate(@account.email, @account.password)
			session[:account_id] = login_account.id
			flash[:notice] = '成功登录'
			redirect_to '/'
		else
			render 'login_get'
		end
	end

	def logout
		if account_login?
			session[:account_id] = nil
			flash[:notice] = '成功退出'
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