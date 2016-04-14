class ApiV1::ArticlesController < ApiController
  def show
    @article = Article.find(params[:id])
    # render @article.to_json
    render :json => {"id" => @article.id,
                     "content" => @article.content,
                     "title" => @article.title,
                     "user_id" => @article.user_id,
                     "updated_at" => @article.updated_at,
                     "created_at" => @article.created_at}, :status => 200
  end
  def create
    @article = Article.new( :title => params[:title] ,
                               :content => params[:content] ,
                               :article_type_id => params[:article_type_id] ,
                               :user_id => params[:user_id])
    if @article.save
      render :json => {:id => @article.id}, :status =>200
    else
      render :json => {:message => 'fail'}, :status =>400
    end
  end
  def update
    @article = Article.find(params[:id])
    @article.title = params[:title]
    @article.content = params[:content]
    if @article.save
      render :json => {"id" => @article.id,
                       "content" => @article.content,
                       "title" => @article.title,
                       "user_id" => @article.user_id,
                       "updated_at" => @article.updated_at,
                       "created_at" => @article.created_at}, :status => 200
    else
      render :json => {:message => 'fail' , :errors => @article.errors}, :status =>400
    end
  end
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    render :json =>{"message" => "Delete OK"}
  end
end
