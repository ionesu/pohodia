module ApplicationHelper

  def pretty_datetime(datetime)
    datetime.to_s.chomp('UTC').chomp(' +0300')
  end

  def pretty_price(price, currency = nil)
    if currency.present?
      number_to_currency(price, precision: 0, delimiter: '', format: "%n %u", locale: :ru, unit: currency)
    else
      number_to_currency(price, precision: 0, delimiter: '', format: "%n %u", locale: :ru, unit: 'RUB')
    end
  end

  def bool_to_string(value)
    if value
      I18n.t "all_pages.labels.yes_label"
    else
      I18n.t "all_pages.labels.no_label"
    end
  end

  def get_value_of_smart_field(parent_object, mask_field, locale)
    parent_object.send(mask_field + '_' + locale.to_s).html_safe rescue "Ошибка перевода"
  end

  def get_public_domain(locale = :en)
    if Rails.env.development?
      locale == :en ? 'pohodia-dev.com:3000' : 'pohodia-dev.ru:3000'
    else
      locale == :en ? 'pohodia.com' : 'pohodia.ru'
    end
  end

  def get_full_url(route, locale)
    get_public_domain(locale) + route
  end

  # мультиязычные тайтлы для селектов
  def smart_collect_for_select(collection)
    return collection.collect { |item| [item.title_ru, item.id] } if @current_locale == :ru
    collection.collect { |item| [item.title_en, item.id] } if @current_locale == :en
  end

  def get_short_description(description)
    return description unless description.present?

    if description.size > 195
      description[0...195] + ' ...'
    else
      description
    end
  end
end
