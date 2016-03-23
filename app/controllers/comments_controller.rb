class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :comment_params , :only =>[:create , :update]

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    redirect_to article_path(comment_params['article_id'])
  end
  private
  def comment_params
    params.require(:comment).permit(:comment , :article_id)
  end
end
