class ArticlesController < ApplicationController
	#before_filter :require_login, :except => [:index, :show]
	include ArticlesHelper

	def index
		@articles = Article.all 
	end

	def show
		@article = Article.find(params[:id])
		@comment = @article.comments.build
	end

	def new
		@article = Article.new
	end

	def create
		@article = Article.new(article_params)
		#@article.title = params[:article][:title]
		@article.save

		flash.notice = "Article '#{@article.title}' Created!"

		redirect_to article_path(@article)
	end

	def destroy
		@article = Article.find(params[:id])
		@article.destroy

		
		redirect_to articles_path
	end

	def edit
		@article = Article.find(params[:id])
	end

	def update
		@article = Article.find(params[:id])
		@article.update_attributes(article_params)

		flash.notice = "Article '#{@article.title}' Updated!"

		redirect_to article_path(@article)
	end

	def article_params
		params.require(:article).permit(:title, :body, :tag_list, :image)
	end

end
