module Admin
  module SSeoDataItem
    class CreateForCountry
      def initialize(administrator, country_id)
        @administrator = administrator
        @country = Country.find_by(id: country_id)
      end

      def main(parent_item_id, parent_item_type)
        if administrator_has_permissions? and @country
          if parent_item_type == 'tour_type'
            create_for_tour_type(parent_item_id)
          elsif parent_item_type == 'tour_category'
            create_for_tour_category(parent_item_id)
          else
            false
          end
        else
          false
        end
      end

      private

      def administrator_has_permissions?
        @administrator.role_permissions['seo_pages'] or @administrator.full_access
      end

      def create_for_tour_type(tour_type_id)
        if TourType.find_by(id: tour_type_id) && SeoDataItem.where(tour_type_id: tour_type_id, public_page_type: 0).size == 0
          SeoDataItem.create(public_page_type: 0, country_id: @country.id, tour_type_id: tour_type_id)
        else
          false
        end
      end

      def create_for_tour_category(tour_category_id)
        Rails.logger.error  "\e[31m create_for_tour_category \e[0m  \n \n"
        tour_category = TourCategory.find_by(id: tour_category_id)
        if tour_category && SeoDataItem.where(tour_category_id: tour_category_id, public_page_type: 1).size == 0
          SeoDataItem.create(public_page_type: 1, country_id: @country.id, tour_type_id: tour_category.tour_type_id,
                             tour_category_id: tour_category.id)
        else
          false
        end
      end
    end
  end
end
