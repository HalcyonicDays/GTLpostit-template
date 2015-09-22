class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:index, :show, :vote]
  before_action :require_same_user, only: [:edit, :update]

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
  end

  def update
    @post.update(post_params) ? (redirect_to posts_path) : (render :edit)
  end

  def vote
    @vote = Vote.create(user: current_user, voteable: @post, vote: params[:vote])
    respond_to do |format|
      format.html do
        flash[:notice] = @vote.valid? ? "You vote was counted." : "You vote was not counted."
        redirect_to :back
      end
      format.js
    end
  end 

  private
    def post_params
      params.require(:post).permit(:title, :url, :description, :category_ids => [])
    end

    def set_post
      @post = Post.find_by_slug(params[:id])
    end

    def require_same_user
      access_denied unless logged_in? and (@post.user != current_user || current_user.role == "admin")
    end
end
