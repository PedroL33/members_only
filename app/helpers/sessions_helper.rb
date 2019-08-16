module SessionsHelper
=begin
    def log_in(user)
        token = User.get_token
        user.update_attribute(:remember_token, token)
        cookies.permanent[:remember_token] = token 
        @current_user = user 
    end
=end
    def log_in(user)
        session[:user_id] = user.id
    end

    def current_user
        @current_user ||= User.find(session[:user_id])
    end

    def current_user=(user)
        @current_user = user
    end

    def sign_out
        session.delete(:user_id)
        @current_user = nil
    end

    def logged_in?
        session.key?(:user_id)
    end

    def restrict_access
        if !logged_in?
            redirect_to login_path
            flash[:danger] = "Must be logged in to see that!"
        end
    end
end