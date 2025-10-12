class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_article, only: [ :show, :edit, :update, :destroy ]

  def index
    @articles = Article.published
                       .search(params[:search])
                       .includes(:user, :comments, images_attachments: :blob)
                       .order(created_at: :desc)
                       .page(params[:page]).per(5)
  end






  def show
    @article = Article.includes(:user, :comments, images_attachments: :blob)
                      .find(params[:id])
    @comment = Comment.new
    @comments = @article.comments.includes(:user).order(created_at: :asc)
  end






  def new
    @article = current_user.articles.new
  end








  def create
    @article = current_user.articles.new(article_params)
    if @article.save
      # Send notifications to all subscribers if article is published
      send_new_article_notifications if @article.published?

      redirect_to @article, notice: "Article was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end







  def update
    was_published = @article.published?

    if @article.update(article_params)
      send_new_article_notifications if @article.published? && !was_published

      redirect_to @article, notice: "Article was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end




  def destroy
    @article.destroy
    redirect_to articles_url, notice: "Article was successfully destroyed."
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

  def send_new_article_notifications
    # Get all subscribers of the current user (article author)
    subscribers = current_user.subscribers

    # Send notification to each subscriber
    subscribers.each do |subscriber|
      NotificationMailer.new_article_notification(subscriber, @article).deliver_later
    end
  end
end
