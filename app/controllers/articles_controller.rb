class ArticlesController < ApplicationController
  include Paginable

  def index
    render_collection(Article.recent)
  end

  def show
    article = Article.find(params[:id])
    render json: serializer.new(article)
  end

  private

  def serializer
    ArticleSerializer
  end
end
