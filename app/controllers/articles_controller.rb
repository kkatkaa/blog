class ArticlesController < ApplicationController
  def index
    @articles = Article.all.order(id: :desc)
  end

  def new
    @article = Article.new
  end

  def create
    # article_params = params.require(:article).permit(:title, :text)
    @article = Article.new(article_params)
   if @article.save
    redirect_to article_path(@article)
   else
    render 'new'
   end
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    # article_params = params.require(:article).permit(:title, :text)
    if @article.update(article_params)
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :text)
  end
end
