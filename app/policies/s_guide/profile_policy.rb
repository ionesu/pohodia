module SGuide
  class ProfilePolicy < ApplicationPolicy

    attr_accessor(:guide)

    def initialize(guide)
      @guide = guide
    end

    def access_to_profile?
      access_to_component?(guide, 'profile') ? true : raise(AccessDenied.new)
    end
  end
end
