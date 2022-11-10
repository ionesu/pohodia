# frozen_string_literal: true

class SiteController < ApplicationController
  layout 'site'
  before_action :all_pages_data

  include FilterHelper

  private

  def all_pages_data
    @menus = Menu.cached_all

    @main_menu_items = @menus.detect { |m| m.descriptor.eql?('in_head') }.menu_items.sort_by { |m| m.position }
    @primary_footer_menu_items = @menus.detect { |m| m.descriptor.eql?('in_footer_primary') }.menu_items.sort_by { |m| m.position }
    @secondary_footer_menu_items = @menus.detect { |m| m.descriptor.eql?('in_footer_secondary') }.menu_items.sort_by { |m| m.position }

    case @current_locale
    when :ru
      set_meta_tags title: 'Активный отдых в России и за рубежом',
                    description: 'Присоединяйтесь к нашему сообществу и начинайте интересно путешествовать вместе с нами!',
                    keywords: 'Pohodia, tour, relax, поход, отдых, семейный, активный, тур, гид',
                    language: 'RU',
                    copyright: 'Походия',
                    index: true
      set_meta_tags og: {
        title: 'Активный отдых в России и за рубежом',
        type:     'website',
        site_name: 'Походия',
        # url:      'http://www.imdb.com/title/tt0117500/',
        # [{
        image: view_context.asset_url('home_section_1.jpg'),
        #  width: 1600,          height: 1067,        }]
        #  width: 1600,          height: 1067,        }]
      }
    else
      set_meta_tags title: 'Active rest in Russia and abroad',
                    description: 'Join our community and start to travel interestingly with us!',
                    keywords: 'Pohodia, tour, relax, поход, отдых, семейный, активный, тур, гид',
                    language: 'EN',
                    copyright: 'Pohodia',
                    index: true
      set_meta_tags og: {
        title: 'Active rest in Russia and abroad',
        type:     'website',
        site_name: 'Pohodia',
        # url:      'http://www.imdb.com/title/tt0117500/',
        # [{
        image: view_context.asset_url('home_section_1.jpg'),
        # width: 1600,              height: 1067,              }]
        # width: 1600,              height: 1067,              }]
      }
    end
  end
end
