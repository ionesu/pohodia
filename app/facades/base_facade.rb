class BaseFacade

  attr_accessor(:current_locale)

  def initialize(current_locale = :ru)
    @current_locale = current_locale
  end

  # мультиязычные тайтлы для селектов
  def smart_collect_for_select(collection)
    return collection.collect { |item| [item.title_ru, item.id] } if current_locale == :ru
    collection.collect { |item| [item.title_en, item.id] } if current_locale == :en
  end
end