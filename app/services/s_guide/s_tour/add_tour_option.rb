module SGuide
  module STour
    class AddTourOption
      MAX_TOUR_OPTION = 50

      attr_accessor :guide, :tour, :option_params, :tour_option

      def initialize(guide, tour, params)
        @guide = guide
        @tour = tour
        @option_params = params
        @tour_option = @tour.tour_options.new
        @response = { object: @tour_option, errors: { tour_option: {} }, result: false }
      end

      def call
        if valid_option_type? && valid_options_qty
          if update_tour_option #? tour_option : false
            @response[:object] = tour_option
            @response[:errors] = []
            @response[:result] = true
          else
            @response[:errors][:tour_option].merge!(tour_option.errors.as_json)
          end
        else
          @response[:errors][:tour_option].merge!({ tour_option: ['invalid type or max count was exceeded'] })
        end
        @response
      end

      private

      def valid_options_qty
        TourOption.where(tour_id: tour.id, option_type: option_params[:option_type].to_i, removed: false).size < MAX_TOUR_OPTION
      end

      def valid_option_type?
        (0..2) === option_params[:option_type].to_i
      end

      def set_option_type
        if option_params[:option_type] == '0'
          tour_option.included_in_price!
        elsif option_params[:option_type] == '1'
          tour_option.not_included_in_price!
        elsif option_params[:option_type] == '2'
          tour_option.equipment!
        else
          tour_option.equipment!
        end
        option_params.delete(:option_type)
      end

      def update_tour_option
        tour_option.assign_attributes(option_params.except(:option_type))
        begin
          set_option_type
        rescue Exception => e
          #Rails.logger.fatal "#{e.inspect}/#{tour_option.errors.inspect}"
        end
        tour_option.save
      end
    end
  end
end