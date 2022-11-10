module Cacheble
  extend ActiveSupport::Concern

  module ClassMethods
    def cached_all
      Rails.cache.fetch(cache_key, expires_in: 5.minutes) do
        scope_for_cache.to_a
      end
    end

    def cache_key
      table_name
    end

    def scope_for_cache
      all.order(:id)
    end
  end
end