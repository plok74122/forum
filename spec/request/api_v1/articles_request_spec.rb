require 'rails_helper'

# RSpec.describe ApiV1::ApiController, type: :controller do
RSpec.describe 'APIarticles', type: :request do
  before do
    @article = Article.create(:title => 'foo', :content => 'bar', :article_type_id => 1, :user_id => 1)
  end

  describe "GET /api/v1/articles/:id" do
    it "should return Article JSON" do
      get "/api/v1/articles/#{@article.id}"
      data = {
          "id" => @article.id,
          "title" => @article.title,
          "content" => @article.content,
          "user_id" => @article.user_id,
          "created_at" => @article.created_at.as_json,
          "updated_at" => @article.updated_at.as_json
      }
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)).to eq(data)
    end
  end

  describe "POST /api/v1/articles" do
    it "should return errors" do
      post "/api/v1/articles"
      expect(response).to have_http_status(400)
    end
    it "should return article id" do
      post "/api/v1/articles", :title => 'foo', :content => 'bar', :article_type_id => 1, :user_id => 1

      article = Article.last
      parsed_data = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(parsed_data).to eq({'id' => article.id})

    end
  end

  describe "PATCH /api/v1/topics/:id" do
    it "should return 400 when no params patch" do
      patch "/api/v1/articles/#{@article.id}"
      expect(response).to have_http_status(400)
    end
    it "should return status 200 and update patch params" do
      patch "/api/v1/articles/#{@article.id}", :title => 'foo_update' , :content => 'bar_edit'
      @article.reload

      data = {
          "id" => @article.id,
          "title" => 'foo_update',
          "content" => 'bar_edit',
          "user_id" => @article.user_id,
          "created_at" => @article.created_at.as_json,
          "updated_at" => @article.updated_at.as_json
      }
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)).to eq(data)
    end
    it "should return status 400 content nil" do
      patch "/api/v1/articles/#{@article.id}", :title => 'foo_update'
      @article.reload

      expect(response).to have_http_status(400)
    end
    it "should return status 400 title nil" do
      patch "/api/v1/articles/#{@article.id}", :content => 'bar_edit'
      @article.reload

      expect(response).to have_http_status(400)
    end
  end

  describe "DELETE /api/v1/topics/:id" do
    it "should delete topic" do
      delete "/api/v1/articles/#{@article.id}"

      expect(response).to have_http_status(200)
      result = Article.find_by_id(@article.id)
      expect(result).to eq(nil)
    end
  end
end
