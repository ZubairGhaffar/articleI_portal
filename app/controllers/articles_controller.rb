# app/controllers/articles_controller.rb
class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.published.order(created_at: :desc).page(params[:page])
  end

def show
  @article = Article.find(params[:id])
  @comment = Comment.new
  @comments = @article.comments.includes(:user).order(created_at: :asc)
end

  def new
    @article = current_user.articles.new
  end

  def create
    @article = current_user.articles.new(article_params)
    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_url, notice: 'Article was successfully destroyed.'
  end

  def my_articles
    @articles = current_user.articles.order(created_at: :desc).page(params[:page])
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

def article_params
  params.require(:article).permit(:title, :content, :published, images: [])
end
end