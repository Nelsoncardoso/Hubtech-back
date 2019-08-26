class ApplicationController < ActionController::API

    include DeviseTokenAuth::Concerns::SetUserByToken
    include Pundit
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    before_action :configure_permitted_parameters, if: :devise_controller?

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
        devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    end

    def user_not_authorized
        render json: { message: "pudit: user not authorized" }.to_json, status: :unauthorized
    end

end
