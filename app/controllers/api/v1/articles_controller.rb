module Api
  module V1
    class ArticlesController < ApplicationController
      def index
        articles = Article.order('created_at DESC');
        render json: {status: 'SUCCESS', message:'Loaded articles', data:articles},status: :ok
      end

      def show
        article = Article.find(params[:id])
        render json: {status: 'SUCCESS', message:'Loaded article', data:article},status: :ok
      end

      def create
        article = Article.new(article_params)
        if article.save
          render json: {status: 'SUCCESS', message:'Saved article', data:article},status: :ok
        else
          render json: {status: 'FAILED', message:'Article not saved', data:article.errors},status: :unprocessable_entity
        end
      end

      def destroy
        if Article.exists?(params[:id])
          article = Article.find(params[:id])
          render json: {status: 'SUCCESS', message:'Deleted article', data:article},status: :ok
        else
          render json: {status: 'FAILED', message:'Article not deleted', data:''},status: :not_found
        end
      end

      def update
        if Article.exists?(params[:id])
          article = Article.find(params[:id])
          if article.update_attributes(article_params)
            render json: {status: 'SUCCESS', message:'Updated article', data:article},status: :ok
          else
            render json: {status: 'FAILED', message:'Article not updated', data:article.errors},status: :unprocessable_entity
          end
        else
          render json: {status: 'FAILED', message:'Article not deleted', data:''},status: :not_found
        end
      end

      private

      def article_params
        params.permit(:title, :body)
      end
    end
  end
end