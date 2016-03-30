class ArticlesController < ApplicationController
  before_action :authenticate_user!
  before_action :article_params , :only =>[:create , :update]
  before_action :article_id_params , :only =>[:edit ,:update ,:show]
  before_action :set_article, :only => [:show, :edit, :update]

  def index
    # @articles = Article.select('count(commnets.article_id) AS comments_count').joins(:comments).group('comments.article_id').order('comments_count')
    # @articles = Article.select('articles.*,count(comments.article_id) as comments_count').joins(:comments).group('comments.article_id').order('comments_count')
    @articles=Article.order('id DESC')
  end
  def new
    @articles = Article.new
    @all_article_type_collection = ArticleType.all
  end
  def create
    new_article = Article.new(article_params)
    new_article.user_id = current_user.id
    flash[:notice] = new_article.save
    redirect_to articles_path
  end
  def edit
    @all_article_type_collection = ArticleType.all

    if(@article.user_id != current_user.id)
      flash[:notice] = "can't access"
      redirect_to articles_path
    end

  end
  def update
    if(@article.user_id != current_user.id)
      flash[:notice] = "can't access"
      redirect_to articles_path
    else
      if(params[:_remove_image] == 1)
        @article.image = nil
      end
      # byebug
      if @article.update(article_params)
        flash[:notice] = "update success"
      end
      redirect_to articles_path
    end
  end

  def show
    @comment = Comment.new
    @comment_list = @article.comments.order('updated_at DESC')
  end

  private

  def set_article
    @article = Article.find(@article_id['id'])
  end

  def article_params
    params.require(:article).permit(:title, :content, :article_type_id ,:image ,:_remove_image)
  end

  def article_id_params
    @article_id = params.permit(:id)
  end
end
