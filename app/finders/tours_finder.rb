class ToursFinder
  attr_reader :scope, :params, :table, :itable

  #
  # @param [ApplicationRecord] scope коллекция для фильтрации
  # @param [Hash] params параметры для фильтрации
  #
  def initialize(scope, params)
    @scope = scope
    @params = params
    @table = scope.arel_table
    @itable = TourPriceItem.arel_table
  end

  #
  # @example
  #   ToursFinder.new(Tour, country_id: 43, minimum_age: 12).call
  #
  def call
    items = scope
    items = by_confirmed(items)
    items = by_status(items)
    items = by_period(items)
    items = by_price(items)
    items = by_duration(items)
    items = by_country_id(items)
    items = by_region_id(items)
    items = by_city_id(items)
    items = by_tour_category_id(items)
    items = by_minimum_age(items)
    items = by_complexities(items)
    items = by_planes(items)
    items.distinct
  end

  protected

  def by_confirmed(items)
    params[:confirmed].present? ? items.where(confirmed: false) : items
  end

  #
  # По статусу
  #
  def by_status(items)
    params[:status].present? ? mappings(items)[params[:status].to_sym] : items
  end

  #
  # По период проведения (дата начала тура)
  #
  # @param [Tour] items
  #
  def by_period(items)
    if params[:period].present?
      period = Tour::FilterPeriod.new(params[:period])
      items.by_period(period)
    else
      items
    end
  end

  #
  # По цене
  #
  def by_price(items)
    if params[:price_start].blank? && params[:price_finish].blank?
      return items
    end

    tour_price_items = TourPriceItem
    tour_price_items =
      if params[:price_start].present? && params[:price_finish].present?
        tour_price_items.where(itable[:price].gteq(params[:price_start])).where(itable[:price].lteq(params[:price_finish]))
      elsif params[:price_start].present?
        tour_price_items.where(itable[:price].gteq(params[:price_start]))
      elsif params[:price_finish].present?
        tour_price_items.where(itable[:price].lteq(params[:price_finish]))
      end

    items.where(tour_price_items: tour_price_items)
  end

  #
  # По длительности (по дням)
  #
  def by_duration(items)
    if params[:duration_from].blank? && params[:duration_to].blank?
      return items
    end

    price_term = (TourPriceItem.arel_table[:date_completion] - TourPriceItem.arel_table[:date_beginning]).to_sql
    tour_price_items = TourPriceItem

    tour_price_items =
      if params[:duration_from].present? && params[:duration_to].present?
        tour_price_items.where("#{price_term} >= ?", params[:duration_from]).where("#{price_term} <= ?", params[:duration_to])
      elsif params[:duration_from].present?
        tour_price_items.where("#{price_term} >= ?", params[:duration_from])
      elsif params[:duration_to].present?
        tour_price_items.where("#{price_term} <= ?", params[:duration_to])
      end

    items.where(tour_price_items: tour_price_items)
  end

  #
  # Поиск по стране
  #
  def by_country_id(items)
    params[:country_id].present? ? items.where(country_id: params[:country_id]) : items
  end

  #
  # Поиск по региону
  #
  def by_region_id(items)
    params[:region_id].present? ? items.where(region_id: params[:region_id]) : items
  end

  #
  # Поиск по городу
  #
  def by_city_id(items)
    params[:city_id].present? ? items.where(city_id: params[:city_id]) : items
  end

  #
  # Поиск по категории тура
  #
  def by_tour_category_id(items)
    params[:tour_category_id].present? ? items.where(tour_category_id: params[:tour_category_id]) : items
  end

  #
  # Поиск по минимальному возросту
  #
  def by_minimum_age(items)
    params[:minimum_age].present? ? items.where(table[:minimum_age].gteq(params[:minimum_age]), params[:minimum_age]) : items
  end

  #
  # Поиск по сложности
  #
  def by_complexities(items)
    if params[:complexities].present?
      return items if params[:complexities].delete_if { |i| i.blank? }.empty?
      items.where(complexity: params[:complexities])
    else
      items
    end
  end

  #
  # Поиск по стране
  #
  def by_planes(items)
    if params[:plane].present?
      if params[:plane].eql?('1')
        items.where(id: TourOption.where(option_type: 'included_in_price', title_ru: 'Перелёт').pluck(:tour_id))
      elsif params[:plane].eql?('2')
        items.where.not(id: TourOption.where(option_type: 'included_in_price', title_ru: 'Перелёт').pluck(:tour_id))
      else
        items
      end
    else
      items
    end
  end

  def mappings(items)
    mappings = {
      active: items.active,
      correction: items.correction,
      moderation: items.moderation,
      suspended: items.suspended
    }
    mappings.default = items
    mappings
  end
end
