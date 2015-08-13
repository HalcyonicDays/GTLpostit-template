class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]

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
    binding.pry
    @post = Post.new(post_params)
    @post.user_id = 1
    @post.save ? (redirect_to post_path(@post)) : (render :new)
  end

  def edit
  end

  def update
    binding.pry
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
