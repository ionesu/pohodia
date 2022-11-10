class Tour::Importer
  class Scope
    extend Dry::Initializer

    option :guide
    option :content
  end

  include Dry::Transaction

  try :import, catch: IndexError

  def import(input)
    doc = Nokogiri::XML(File.open(input.content.file.file))
    tour_category = TourCategory.find_by(title_ru: 'Треккинг')

    doc.css('tours').css('tour').each do |node|
      begin
        Tour.transaction do
          tour = Tour.find_by(external_url: node.xpath('external_url').inner_text)
          if tour.blank?
            create_tour(input, node, tour_category)
          else
            update_tour(tour, node)
          end
        end
      rescue StandardError => e
        Rails.logger.error(e)
      end
    end
  end

  private

  def create_tour(input, node, tour_category)
    tour = Tour.new(
      guide: input.guide,
      many_days: true,
      avatar_external_url: node.css('tour_images value').first.css('image').inner_text,
      external_url: node.xpath('external_url').inner_text,
      title_ru: node.xpath('title_ru').inner_text,
      description_ru: node.xpath('description_ru').inner_text,
      tour_category: TourCategory.find_by(title_ru: node.css('tour_category').inner_text) || tour_category,
      complexity: node.xpath('complexity').inner_text || 1,
      length_of_route: node.xpath('length_of_route').inner_text,
      tour_images: node.css('tour_images value')[0..8].map(&method(:create_tour_image)),
      tour_options: node.css('tour_options value').map(&method(:create_tour_option)),
      tour_price_items: node.css('tour_price_items value').map(&method(:create_tour_price_item)),
      tour_routes: node.css('tour_routes value').map(&method(:create_tour_route)),
    )
    tour.custom_location = node.xpath('location').inner_text

    tour_route_points = node.css('tour_route_points value').each_with_index.map do |tour_route_point, index|
      TourRoutePoint.new(
        geo_latitude: tour_route_point.css('geo_longitude').inner_text,
        geo_longitude: tour_route_point.css('geo_latitude').inner_text,
        position: index + 1
      )
    end

    tour.global_status = 0
    tour.confirmed = true

    tour.save!(validate: false)

    tour.tour_images.each do |image|
      image.tour = tour
      image.save
    end

    tour.tour_options.each do |option|
      option.tour = tour
      option.save!(validate: false)
    end

    tour.tour_routes.each do |route|
      route.tour = tour
      route.remote_image_url = node.css('tour_images value').first.css('image').inner_text
      route.save!(validate: false)
    end

    tour.tour_price_items.each do |price_item|
      price_item.tour = tour
      price_item.save!(validate: false)
    end

    tour_route_points.each do |tour_route_point|
      tour_route_point.tour_route = tour.tour_routes.first
      tour_route_point.save!
    end

    tour.avatar = open(node.css('tour_images value').last.css('image').inner_text)
    tour.large_avatar = open(node.css('tour_images value').last.css('image').inner_text)
    tour.save
  end

  def update_tour(tour, node)
    tour.tour_price_items.destroy_all
    tour.tour_price_items = node.css('tour_price_items value').map(&method(:create_tour_price_item))

    tour.tour_price_items.each do |price_item|
      price_item.tour = tour
      price_item.save!(validate: false)
    end
  end

  def create_tour_image(element)
    TourImage.new(
      remote_image_url: element.css('image').inner_text
    )
  end

  def tour_option(option)
    maps = {
      'included_in_price' => 0,
      'not_included_in_price' => 1
    }
    maps[option]
  end

  def create_tour_option(element)
    TourOption.new(
      title_ru: element.css('title_ru').inner_text,
      option_type: tour_option(element.css('option_type').inner_text)
    )
  end

  def create_tour_price_item(element)
    TourPriceItem.new(
      date_beginning: element.css('date_beginning').inner_text,
      date_completion: element.css('date_completion').inner_text,
      free_places: element.css('free_places').inner_text,
      price: element.css('price').inner_text,
      total_places: element.css('total_places').inner_text,
      currency: element.css('currency').inner_text || 'RUB'
    )
  end

  def create_tour_route(element)
    TourRoute.new(
      title_ru: element.css('title_ru').inner_text,
      description_ru: element.css('description_ru').inner_text,
    )
  end
end
