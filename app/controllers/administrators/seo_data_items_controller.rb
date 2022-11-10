class Administrators::SeoDataItemsController < AdministratorsController

  # создать seo страницу для связки страна-тип тура, страна-категория тура
  def create_for_country
    prm = params[:seo_data_item]
    # страна -> тип тура или страна -> категория тура
    parent_item_id = prm[:parent_item_type] == 'tour_type' ? prm[:tour_type_id] : prm[:tour_category_id]
    Admin::SSeoDataItem::CreateForCountry.new(current_administrator, prm[:country_id]).main(parent_item_id,
                                                                                            prm[:parent_item_type])
    redirect_back(fallback_location: administrator_root_path)
  end

  def create_for_region
    # main(current_administrator, region_id, tour_parent_item_id, tour_parent_item_type)
    # tour_parent_item_type - страница типа туров, категории туров или гидов региона
  end

  # создание страниц для города
  def create_for_city
    # main(current_administrator, city_id, tour_parent_item_id, tour_parent_item_type)
    # tour_parent_item_type - страница типа туров, категории туров или гидов страны
  end

  def edit
    @page = SeoDataItem.find(params[:id])
  end

  def update
    prm = params.require(:seo_data_item).permit(:text_above_ru, :text_above_en, :text_below_ru, :text_below_en, :image,
                                                :large_image, :meta_title_ru, :meta_title_en, :meta_description_ru,
                                                :meta_description_en, :meta_keywords_ru, :meta_keywords_en)
    Admin::SSeoDataItem::Update.new(current_administrator, params[:id], prm).main
    redirect_back(fallback_location: administrator_root_path)
  end

end