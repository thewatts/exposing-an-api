class ArticlesController < ApplicationController
  respond_to :html, :json, :xml

  def show
    @article = Article.find(params[:id])
  end

  def index
    @articles, @tag = Article.search_by_tag_name(params[:tag])
    respond_with(@articles)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(params[:article])
    flash[:notice] = @article.save ? "Article was created." : "Article failed to save"
    respond_with @article do |format|
      format.html { @article.valid? redirect_to(@article) : render(:new) }
      format.json { render :json => @article }
      format.xml  { render :xml => @article }
    end
  end

  def edit
    @article = Article.find params[:id]
  end

  def update
    @article = Article.find params[:id]
    if @article.update_attributes(params[:article])
      flash[:notice] = "Article was updated."
      redirect_to article_path(@article)
    else
      render :edit
    end
  end

  def destroy
    article = Article.find params[:id]
    article.destroy
    flash[:notice] = "#{article} was destroyed."
    redirect_to articles_path
  end
end
