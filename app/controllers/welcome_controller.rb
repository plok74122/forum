class WelcomeController < ApplicationController
  # before_action :authenticate_user!
  # before_action :set_all_article , :only =>  [:index]
  def index
    @q =Article.ransack(params[:q])
    @articles = @q.result(distinct: true)
    if params[:sort] == "id"
      @articles = @articles.order("id")
    elsif params[:sort] == "updated"
      @articles = @articles.order("updated_at DESC")
    # elsif params[:sort] == "comments+asc"
    #   @articles = @articles.select('articles.*,count(comments.article_id) as comments_count').joins(:comments).group('comments.article_id').order('comments_count')
    # elsif params[:sort] == "comments+desc"
    #   @articles = @articles.select('articles.*,count(comments.article_id) as comments_count').joins(:comments).group('comments.article_id').order('comments_count DESC')
    else
      @articles = @articles.order("id DESC")
    end

    @articles = @articles.page( params[:page] )
  end
  def about
    @user = User
    @articles = Article
    @comments = Comment
  end

  private
  # def set_all_article
  #   @articles = current_user.articless.find( params[:id])
  # end
end
