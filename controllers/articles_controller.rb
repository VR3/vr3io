class ArticlesController < ApplicationController

    before_action :authenticate_user!, only: [:new, :create, :edtt, :update, :destroy]

    before_action :set_article, only: [:show, :edit, :update, :destroy]

    def index
        @articles = Article.all.order("created_at asc")
    end

    def new
        @article = Article.new
    end
    
    def create
        @article = Article.new article_params
        @article.logo = params[:article][:logo]
        if @article.save
            redirect_to 'index'    
        else
            render "new"
        end
    end
    
    def show
        @article
    end
    
    def edit
        @article
        render 'edit'
    end

    def update
        @article
        @article.logo = params[:article][:logo]
        @article.update(article_params)
        redirect_to 'index'
    end
    
    def destroy
        @article.destroy
        redirect_to 'index'
    end
    
    private

    def set_article
        @article = Article.friendly.find(params[:id])
    end

    def article_params
        params.require(:article).permit(:title, :author, :source, :link, :body, :logo)    
    end

end
