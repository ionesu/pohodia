class CountriesFinder
  def initialize(scope, params)
    @scope = scope
    @params = params
  end

  def call
    items = scope
    items = paginate(items)
    items.distinct
  end

  private

  def paginate(items)
    if params[:page]
      items.paginate(page: params[:page], per_page: 20)
    else
      items
    end
  end
end