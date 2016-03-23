class WelcomeController < ApplicationController
  # before_action :authenticate_user!
  def index

  end
  def about
    @user = User
    @articles = Article
    @comments = Comment
  end
end
