module SessionsHelper
    def log_in(user)
        token = User.get_token
        user.update_attribute(:remember_token, token)
        cookies.permanent[:remember_token] = token 
        @current_user = user 
    end

    def current_user
        @current_user ||= User.find_by(remember_token: cookies[:remember_token])
    end

    def current_user=(user)
        @current_user = user
    end

    def sign_out
        cookies.delete(:remember_token)
        @current_user = nil
    end

    def logged_in?
        !current_user.nil?
    end

    def restrict_access
        if !logged_in?
            redirect_to login_path
            flash[:danger] = "Must be logged in to see that!"
        end
    end
end