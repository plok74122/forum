class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :comment_params, :only => [:create, :update]
  before_action :set_comment, :only => [:destroy]

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    redirect_to article_path(comment_params['article_id'])
  end

  def destroy
    if current_user.id == @comment.user_id
      @comment.delete
    end
    respond_to do |format|
      format.html
      format.js #destroy.js.erb
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :article_id)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
