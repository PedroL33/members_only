class SessionsController < ApplicationController
    def new
    end

    def create
        user = User.find_by(email: params[:sessions][:email].downcase)
        if user && user.authenticate(params[:sessions][:password])
            log_in user
            flash[:success] = "Successfully signed in as #{current_user.name}."
            redirect_to root_url
        else
            flash.now[:danger] = "Invalid email and password combination"
            render 'new'
        end
    end

    def delete
        sign_out if logged_in?
        flash.now[:success] = "Successfully signed out."
        redirect_to root_url
    end

end
