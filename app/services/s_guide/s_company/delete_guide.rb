module SGuide
  module SCompany
    class DeleteGuide

      attr_accessor :guide, :permission

      def initialize(guide, permission_id)
        @guide = guide
        @permission = GuideCompanyPermission.find_by(id: permission_id)
      end

      def call
        if permission && !deleted_guide_is_admin?
          permission.destroy
        end
      end

      private

      def deleted_guide_is_admin?
        permission.guide_id == guide.id
      end
    end
  end
end