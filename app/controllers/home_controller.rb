class HomeController < ApplicationController

	def index
		@blogs=Blog.order('id DESC').paginate(page: params[:page])
	end

end