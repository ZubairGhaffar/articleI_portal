class NotificationMailer < ApplicationMailer
  default from: "zubairghaffar.1046@gmail.com"



  # Send email when someone subscribes to a user
  def new_subscriber_notification(subscriber, author)
    @subscriber = subscriber
    @author = author
    mail(to: @author.email, subject: "#{@subscriber.name} subscribed to you!")
  end



  # Send email when someone comments on a user's article
  def new_comment_notification(comment, article_author)
    @comment = comment
    @article = comment.article
    @commenter = comment.user
    @article_author = article_author
    mail(to: @article_author.email, subject: "New comment on your article: #{@article.title}")
  end



  # Send email to all subscribers when a new article is published
  def new_article_notification(subscriber, article)
    @subscriber = subscriber
    @article = article
    @author = article.user
    mail(to: @subscriber.email, subject: "#{@author.name} published a new article: #{@article.title}")
  end
end
