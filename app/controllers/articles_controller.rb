class ArticlesController < ApplicationController
  before_action :find_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.all.order(id: :desc)
    @articles = @articles.where("? = any(tags)", params[:q]) if params[:q].present?
  end

  def show
    @comment = Comment.new(commenter: session[:commenter])
  end

  def new
    @article = Article.new
    @user = User.new
  end

  def edit
    if current_user != @article.user && !current_user&.admin?
      flash[:alert] = "You are not allowed to be here"
     return redirect_to articles_path
   end
  end

  def create
    # article_params = params.require(:article).permit(:title, :text)
    @article = Article.new(article_params)
    @article.user = current_user if current_user
   if @article.save
     flash[:notice] = "You've successfuly add this article"
     redirect_to article_path(@article)
   else
    render 'new'
   end
  end

  def update
    # article_params = params.require(:article).permit(:title, :text)
    if current_user != @article.user && !current_user&.admin?
      flash[:alert] = "You are not allowed to be here"
      return redirect_to article_path(@article)
    end

    if @article.update(article_params)
      flash[:notice] = "You've successfuly update this article"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def destroy
    if current_user != @article.user && !current_user&.admin?
      flash[:alert] = "You are not allowed to delete"
      return redirect_to articles_path
    end

     @article.destroy
     flash[:notice] = "You've delete your article"
     redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :text, :tags, :user)
  end

  def find_article
    @article = Article.find(params[:id])
  end
end
