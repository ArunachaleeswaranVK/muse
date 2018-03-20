class PostsController < ApplicationController
    
    before_action :set_post , only: [:edit,:update,:show,:destroy,:upvote ,:downvote]
    before_action :authenticate , except: [:index,:show]
    
    def index
        @posts = Post.search(params[:search])  
    end
    
    def show
        @comments = Comment.where(post_id: @post)
        @random_post = Post.where.not(id: @post).order("RANDOM()").first
        
        @post_count = Post.all.count
    end    
    
    def new
        @post = current_user.posts.build
    end
    
    def create
        @post = current_user.posts.build(post_params)
        
        if @post.save
            redirect_to root_path
        else 
            render "new"
        end    
    end
    
    def edit
        
        
    end
    
    def update
        if @post.update(post_params)
            redirect_to @post
        else
            render "edit"
        end    
    end
    
    def destroy
        @post.destroy
        redirect_to root_path
    end
    
    def upvote
        @post.upvote_by current_user
        redirect_to :back
    end 
    
    def downvote
        @post.downvote_by current_user
        redirect_to :back
    end 
    
    private
    
    def authenticate
       authenticate_user! && current_user.admin? 
    end    
    
    def post_params
       params.require(:post).permit(:title,:link,:description ,:image) 
    end 
    
    def set_post
       @post = Post.find(params[:id]) 
    end    
end
