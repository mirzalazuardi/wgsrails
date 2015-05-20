class ArticlesController < ApplicationController
  def index
    @articles = Article.all
    #@articles = Article.status_active 
  end

  def new
    @article = Article.new
  end

  def show
    @article = Article.find_by_id(params[:id])
  end

  def edit
    @article = Article.find_by_id(params[:id])
  end

  def create
    @article = Article.new(params_article)
    if @article.save
    flash[:notice] = "Success Add Records"
    redirect_to action: 'index'
    else
      flash[:error] = "data not valid"
      render 'new'
    end
  end

  def update
    @article = Article.find_by_id(params[:id])

    if @article.update(params_article)
    flash[:notice] = "Success Update Records"
    redirect_to action: 'index'
    else
      flash[:error] = "data not valid"
      render 'edit'
    end
  end

  def destroy
    @article = Article.find_by_id(params[:id])

    if @article.destroy
    flash[:notice] = "Success Delete Records"
    redirect_to action: 'index'
    else
      flash[:error] = "fails delete a records"
      render 'edit'
    end
  end

  def params_article
    params.require(:article).permit(:title, :content, :status)
  end

end
