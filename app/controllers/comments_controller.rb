class CommentsController < ApplicationController
  before_action :require_user

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    
    @comment.save ? (redirect_to post_path(@post)) : (render 'posts/show' )
  end

  def vote
    @comment = Comment.find(params[:id])
    @vote = Vote.create(user: current_user, voteable: @comment, vote: params[:vote])
    flash[:notice] = @vote.valid? ? "You vote was counted." : "You vote was not counted."
    redirect_to :back
  end 

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end