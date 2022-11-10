# frozen_string_literal: true

class Administrators::PagesController < AdministratorsController
  before_action :set_page, only: [:edit, :update, :destroy]

  def index
    @pages = Page.all.select(:id, :title_ru, :title_en, :slug_ru, :slug_en)
  end

  def new
    @page = Page.new
  end

  def edit
  end

  def create
    result = Admin::SPage::Create.new(current_administrator, permited_params).main
    if result
      redirect_to edit_administrators_page_path(result), notice: 'Запись успешно добавлена'
    else
      redirect_back(fallback_location: administrator_root_path)
    end
  end

  def update
    result = Admin::SPage::Update.new(current_administrator, params[:id], permited_params).main
    notice_message = result ? 'Информация обновлена' : 'Произошла ошибка'
    redirect_back(fallback_location: administrator_root_path)
  end

  def destroy
    @page.destroy
    redirect_back(fallback_location: administrator_root_path)
  end

  private

  def set_page
    @page = Page.find(params[:id])
  end

  def permited_params
    params
      .require(:page)
      .permit(
        :title_ru, :title_en, :description_ru, :description_en, :slug_ru, :slug_en,
        :meta_title_ru, :meta_title_en, :meta_description_ru, :meta_description_en,
        :meta_keywords_ru, :meta_keywords_en
      )
  end
end