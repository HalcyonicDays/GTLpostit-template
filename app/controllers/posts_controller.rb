class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]
  before_action :require_user, except: [:index, :show]

  def index
    @posts = Post.all
  end

  def show
    (render :index and return) if @post.nil?
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post.save ? (redirect_to post_path(@post)) : (render :new)
  end

  def edit
    if @post.user != current_user
      flash[:error] = "You cannot edit posts which are not yours."
      redirect_to root_path
    end
  end

  def update
    @post.update(post_params) ? (redirect_to posts_path) : (render :edit)
  end

  private
    def post_params
      params.require(:post).permit(:title, :url, :description, :category_ids => [])
    end

    def set_post
      @post = Post.find(params[:id])
    end
end
