# app/controllers/comments_controller.rb
class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article

  def create
    @comment = @article.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @article, notice: 'Comment was successfully added.'
    else
      redirect_to @article, alert: 'Error adding comment.'
    end
  end

  def destroy
    @comment = @article.comments.find(params[:id])
    @comment.destroy if @comment.user == current_user
    redirect_to @article, notice: 'Comment was successfully removed.'
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end