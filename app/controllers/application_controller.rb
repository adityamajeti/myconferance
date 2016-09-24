class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
  	if resource.role == "Super_Manager" || resource.role == "Manager"
  		portal_users_path
    elsif resource.role == "Client" || resource.role == "Guest"
      portal_conference_rooms_path  
  	end
  end

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end

  rescue_from CanCan::AccessDenied do |exception|  
   	flash[:error] = "Access denied!" 
    if current_user.role == "Super_Manager" || current_user.role == "Manager"
	    redirect_to root_url
    elsif current_user.role == "Client" || current_user.role == "Guest"
      redirect_to portal_conference_rooms_path  
    end      
  end

end
