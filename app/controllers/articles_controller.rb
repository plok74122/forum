class ArticlesController < ApplicationController
  before_action :article_params , :only =>[:create , :update]
  before_action :article_edit_params , :only =>[:edit ,:update]

  def index
    @articles = Article.includes(:article_type)
  end
  def new
    @articles = Article.new
    @all_article_type_collection = ArticleType.all
  end
  def create
    new_article = Article.create(article_params)
    flash[:notice] = new_article
    redirect_to articles_path
  end
  def edit
    @article = Article.find(article_edit_params['id'])
    @all_article_type_collection = ArticleType.all

  end
  def update
    @article = Article.find(article_edit_params['id'])
    @article.update(article_params)
    redirect_to articles_path
  end
  private
  def article_params
    params.require(:article).permit(:title, :content, :article_type_id )
  end
  def article_edit_params
    @article_id = params.permit(:id)
  end
end
