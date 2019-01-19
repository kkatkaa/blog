class ArticlesController < ApplicationController
  before_action :find_article, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]
  before_action :authorize_article, only: [:edit, :update, :destroy]

  def index
    @articles = Article.all.order(id: :desc)
    @articles = @articles.where("? = any(tags)", params[:q]) if params[:q].present?
  end

  def show
    @comment = Comment.new
    @like = Like.find_or_initialize_by(article: @article, user: current_user)

    respond_to do |format|
      format.html do
        @article.increment!(:views_count)
        render
      end

      format.json do
        sleep(rand(100.0)/50)
        render json: {
        id: @article.id,
        title: @article.title,
        text: @article.text,
        views_count: @article.views_count,
        likes_count: @article.likes.count,
        comments_count: @article.comments.count
      }
      end
    end
  end

  def new
    @article = Article.new
    @user = User.new
  end

  def edit
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
    if @article.update(article_params)
      flash[:notice] = "You've successfuly update this article"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    flash[:notice] = "You've delete your article"
    redirect_to articles_path
  end

  private

  def authorize_article
    if current_user != @article.user && !current_user&.admin?
      flash[:alert] = "You are not allowed to be here"
      redirect_to articles_path
      false
    else
      true
    end
  end

  def article_params
    params.require(:article).permit(:title, :text, :tags, :user)
  end

  def find_article
    @article = Article.find(params[:id])
  end
end
