class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article

  def create
    @comment = @article.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      # Send notification to article author if it's not the author commenting on their own article
      if @article.user != current_user
        NotificationMailer.new_comment_notification(@comment, @article.user).deliver_later
      end

      redirect_to @article, notice: "Comment was successfully created."
    else
      redirect_to @article, alert: "Error creating comment."
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to @article, notice: "Comment was successfully deleted."
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
