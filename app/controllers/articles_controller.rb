class ArticlesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    articles = Article.includes(:user).order(created_at: :desc)
    render json: articles, each_serializer: ArticleListSerializer
  end

  def show
    article = find_article
    render json: article
  end

  private

  def find_article
    Article.find(params[:id])
  end

  def record_not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end
end
