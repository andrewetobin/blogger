class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :destroy, :edit, :update]
  before_action :require_login, except: [:index, :show]

  def index
    @articles = Article.all
  end

  def show
    @comment = Comment.new
    @comment.article_id = @article.id
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.save
    flash.notice = "Article '#{@article.title}' created!"
    redirect_to article_path(@article)
  end

  def destroy
    Article.destroy(params[:id])

    flash.notice = "Article '#{@article.title}' deleted!"
    redirect_to articles_path
  end

  def update
  @article.update(article_params)

  flash.notice = "Article '#{@article.title}' updated!"

  redirect_to article_path(@article)
end

  def edit
  end

  private

    def article_params
      params.require(:article).permit(:title, :body, :tag_list, :image)
    end

    def set_article
      @article = Article.find(params[:id])
    end

end
