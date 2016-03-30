class LikesController < ApplicationController
  before_action :set_article, :only => [:create ,:destroy]

  def create
    like = @article.finy_like_by(current_user)
    if like
      # do nothing
    else
      @like = @article.likes.create!(:user => current_user)
    end
    respond_to do |format|
      format.html { redirect_to :back }
      format.js{ render "like" }
      # format.js  { render "like" }
    end
  end

  def destroy
    @like = @article.finy_like_by(current_user)
    @like.destroy
    @like = nil
    respond_to do |format|
      format.html { redirect_to :back }
      format.js{ render "like" }
      # format.js  { render "like" }
    end
  end

  private
  def set_article
    @article = Article.find(params[:article_id])
  end
end
