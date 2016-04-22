module ApplicationHelper

	def current_account
		return @current_account if @current_account
		return @current_account = Account.find_by_id(session[:account_id]) if session[:account_id]
		if request.cookies['user'] && (@current_account = Account.validate_cookie(request.cookies['user']))
			session[:account_id] = @current_account.id
			return @current_account
		end
	end

	def account_login?
		current_account ? true : false
	end

end