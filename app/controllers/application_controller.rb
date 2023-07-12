class ApplicationController < ActionController::Base
   before_action :authenticate_user!,except: [:top, :about]
   before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
  end

  def after_sign_in_path_for(resource)
    case resource
     when Admin
        admins_home_path
      when User
        public_user_path(current_user)
      end
  end

end
