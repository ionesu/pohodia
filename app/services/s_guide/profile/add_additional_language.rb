module SGuide
  module Profile
    class AddAdditionalLanguage

      attr_accessor(:guide, :language)

      def initialize(guide, language_id)
        @guide = guide
        @language = Language.find_by(id: language_id)
      end

      def call
        if language && !guide_already_support_language?
          guide.additional_languages_ids << language.id
          guide.save
          guide
        end                
      end

      def guide_already_support_language?
        guide.main_language_id == language.id || guide.additional_languages_ids.include?(language.id)
      end

    end
  end
end