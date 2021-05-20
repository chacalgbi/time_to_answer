class ApplicationController < ActionController::Base
	layout :layout_by_resource
	before_action :check_pagination

	protected

	def layout_by_resource
		devise_controller? ? "#{resource_class.to_s.downcase}_devise" : "application"
	end

	def check_pagination
		unless user_signed_in?
			params.extract!(:page)
		end
		
	end

end




=begin

	Mesma coisa do código acima
	
	def layout_by_resource
		if devise_controller? && resource_class == Admin
			"admin_devise"
		elsif devise_controller? && resource_class == User
			"user_devise"
		else
			"application"
		end
	end
	
=end