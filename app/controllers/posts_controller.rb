class PostsController < ApplicationController
    before_action :restrict_access, only: [:new, :create]

    def new
    end

    def index
        @posts = Post.all
        @user = User.find_by(remember_token: cookies[:remember_token])
    end
    
    def create
        @post = Post.new(post_params)
        @post.user_id = User.find_by(remember_token: cookies[:remember_token]).id
        if @post.save
            flash[:success] = "Post successfully made."
            redirect_to root_url
        else
            flash[:danger] = "Must contain content."
            render 'new'
        end
    end 

    private
        def post_params
            params.require(:posts).permit(:content)
        end
end
