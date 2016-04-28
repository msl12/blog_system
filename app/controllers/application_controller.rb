class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound do |exception|
    halt_404
  end

  private
  def current_account
  	return @current_account if @current_account
	return @current_account=Account.find_by_id(session[:account_id]) if session[:account_id]
  end

  def account_login?
  	current_account ? true : false
  end

  def account_admin?
    current_account && current_account.admin? ? true : false
  end

  def halt_403
    render 'error/403'
  end

  def halt_404
    render 'error/404'
  end

  def halt_401
    render 'error/401'
  end

end