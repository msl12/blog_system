class HomeController < ApplicationController

	def index
		@blogs=Blog.order('id DESC').paginate(page: params[:page])
	end

	def login_get
		@account=Account.new
	end

	def login_post
		#login_tries=APP_CACHE.read("#{CACHE_PREFIX}/login_counter/#{request.ip}")
		#halt 403 if login_tries && login_tries.to_i>5  # reject ip if login tries is over 5 times
		@account=Account.new(account_params)
		if login_account=Account.authenticate(@account.email, @account.password)
			session[:account_id]=login_account.id
			#response.set_cookie('user', {:value => login_account.encrypt_cookie_value, :path => "/", :expires => 2.weeks.since, :httponly => true}) if params[:remember_me]
			flash[:notice]='成功登录'
			redirect_to '/'
		else
			# retry 5 times per one hour
			#APP_CACHE.increment("#{CACHE_PREFIX}/login_counter/#{request.ip}", 1, :expires_in => 1.hour)
			render 'login_get'
		end
	end

	def logout
		if account_login?
			session[:account_id]=nil
			#response.delete_cookie("user")
			#flash[:notice] = "成功退出"
		end
		redirect_to '/'
	end

	private
	def account_params
		params.require(:account).permit(:email, :password)
	end

end