# == Schema Information
#
# Table name: countries
#
#  id                         :integer          not null, primary key
#  title_ru                   :string(60)
#  title_en                   :string(60)
#  description_ru             :text
#  description_en             :text
#  avatar                     :string
#  large_avatar               :string
#  slug_ru                    :string
#  slug_en                    :string
#  meta_title_ru              :string
#  meta_title_en              :string
#  meta_description_ru        :text
#  meta_description_en        :text
#  meta_keywords_ru           :string
#  meta_keywords_en           :string
#  iso_code                   :string
#  guides_meta_title_ru       :string
#  guides_meta_title_en       :string
#  guides_meta_description_ru :text
#  guides_meta_description_en :text
#  guides_meta_keywords_ru    :string
#  guides_meta_keywords_en    :string
#  created_at                 :datetime         default(Tue, 18 Sep 2018 07:34:07 UTC +00:00), not null
#  updated_at                 :datetime         default(Tue, 18 Sep 2018 07:34:07 UTC +00:00), not null
#

class Country < ApplicationRecord
	include Cacheble

  mount_uploader :avatar,       CountryAvatarUploader
  mount_uploader :large_avatar, CountryLargeAvatarUploader

  has_many :regions
  has_many :cities
  has_many :tours
  has_many :seo_data_items
  has_many :guide_companies
  
  include PgSearch  
  pg_search_scope :search_by_autocomplete, 
  									:against => [
  										[:title_ru, 'A'], [:title_en, 'A'], 
  										[:description_ru, 'B'], [:description_en, 'B']
  									],
  									:associated_against => {
  										:tours_mailer => [
	  										[:title_ru, 'A'], [:title_en, 'A'], 
	  										[:description_ru, 'B'], [:description_en, 'B']
	  									],
    									:region => [:title_ru, :title_en],
    									:city => [:title_ru, :title_en]    									
  									},
  									:using => {
	                    :tsearch => {
	                    	:prefix => true
	                    	#, :dictionary => "english"
	                    }	                    
	                  }
  
  
	def to_meta_tags		
		locale = @current_locale.try(:to_s) 
		locale ||= 'ru'
		
		if seo_data = seo_data_items.where(public_page_type: 0).first
			title = seo_data.send("meta_title_#{locale}".to_sym)
			description = seo_data.send("meta_description_#{locale}".to_sym)
			keywords = seo_data.send("meta_keywords_#{locale}".to_sym)
			keywords = keywords.split(',').map{|k| k.strip} if keywords.present?
		end
		
		title = self.send("meta_title_#{locale}".to_sym) if title.blank?
		description = self.send("meta_description_#{locale}".to_sym) if description.blank?
		if keywords.blank?
			keywords = self.send("meta_keywords_#{locale}".to_sym) 
			keywords = keywords.split(',').map{|k| k.strip} unless keywords.blank?
		end		
		
		title = self.send("title_#{locale}".to_sym) if title.blank?
		description = self.send("description_#{locale}".to_sym) if description.blank?
		keywords = [title_ru, title_en, 'страна', 'country'] if keywords.blank?
		image = [large_avatar]
    
		{ title: title, description: description, keywords: keywords, og: {title: title, image: image}}		
  end
  
end
