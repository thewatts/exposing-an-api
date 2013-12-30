class ArticlesController < ApplicationController
  respond_to :html, :json

  def show
    @article = Article.find(params[:id])
    respond_with(@article)
  end

  def index
    @articles, @tag = Article.search_by_tag_name(params[:tag])
    respond_with(@articles)
  end

  def new
    @article = Article.new
    respond_with(@article)
  end

  def create
    @article = Article.new(params[:article])
    flash[:notice] = @article.save ? "Article was created." : "Article failed to save"
    respond_with @article
  end

  def edit
    @article = Article.find params[:id]
    respond_with @article
  end

  def update
    @article = Article.find params[:id]
    if @article.update_attributes(params[:article])
      flash[:notice] = "Article was updated."
    else
      flash[:notice] = "Article failed to update."
    end
    respond_with @article
  end

  def destroy
    article = Article.find params[:id]
    article.destroy
    flash[:notice] = "#{article} was destroyed."
    redirect_to articles_path
  end
end
