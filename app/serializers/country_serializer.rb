class CountrySerializer < ActiveModel::Serializer
  attributes :id, :title_ru, :title_en, :avatar, :large_avatar
end