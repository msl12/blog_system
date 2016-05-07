module ApplicationHelper
	include GitHub

	def current_account
		return @current_account if @current_account
		return @current_account = Account.find_by_id(session[:account_id]) if session[:account_id]
	end

	def account_login?
		current_account ? true : false
	end

	def account_admin?
		current_account && current_account.admin? ? true : false
	end

end