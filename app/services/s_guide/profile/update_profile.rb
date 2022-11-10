module SGuide
  module Profile
    class UpdateProfile

      attr_accessor(:guide, :params)

      def initialize(guide, params)
        @guide    = guide
        @params   = params
        @response = { object: @guide, errors: { guide: {} }, result: false }
      end

      def call
        city = City.find_by(id: params[:city_id])

        if check_main_language?
          update_guide
          set_region_and_country(city)
          if guide.save
            @response[:object] = @guide
            @response[:errors] = []
            @response[:result] = true
          else
            @response[:errors][:guide].merge!(@guide.errors.as_json)
          end
        else
          @response[:errors][:guide].merge!({ main_language_id: ['check language'] })
        end

        @response
      end

      private

      def check_city?
        City.find_by(id: params[:city_id])
      end

      def check_main_language?
        language = Language.find_by(id: params[:main_language_id])
        if language && !guide.additional_languages_ids.include?(language.id)
          language
        else
          @response[:errors][:guide].merge!({ city_id: ['no tour category'] }) unless @tour_category
        end
      end

      def update_guide
        guide.assign_attributes(params)
      end

      def set_region_and_country(_city)
        guide.region_id  = params[:region_id]
        guide.country_id = params[:country_id]
      end
    end
  end
end