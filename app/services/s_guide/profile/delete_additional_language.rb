module SGuide
  module Profile
    class DeleteAdditionalLanguage

      attr_accessor(:guide, :language)

      def initialize(guide, language_id)
        @guide = guide
        @language = Language.find_by(id: language_id)
      end

      def call
        if language && guide.additional_languages_ids.include?(language.id)
          guide.additional_languages_ids.delete(language.id)
          guide.save
        end
      end
    end
  end
end