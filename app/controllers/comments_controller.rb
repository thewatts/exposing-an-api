class CommentsController < ApplicationController
  respond_to :html, :json

  def create
    article = Article.find(params[:comment][:article_id])
    comment = article.comments.create(params[:comment])
    flash[:notice] = "Your comment was added."
    respond_with article
  end
end
