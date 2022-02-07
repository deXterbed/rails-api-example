module Paginable
  extend ActiveSupport::Concern

  private

  def render_collection(collection)
    paginated = paginator.call(
      collection,
      params: pagination_params,
      base_url: request.url
    )
    options = {
      meta: paginated.meta.to_h,
      links: paginated.links.to_h
    }
    render json: serializer.new(paginated.items, options), status: :ok
  end

  def paginator
    JSOM::Pagination::Paginator.new
  end

  def pagination_params
    params.permit![:page]
  end
end