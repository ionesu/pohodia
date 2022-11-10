// страница страна - управление seo страницами
// /administrators/countries/:id/seo_data_items

if (document.body.className.match('countries-seo') ) {
    $("#type_select_area #seo_data_item_tour_type_id").change(function() {
        state_select_tour_category($(this).val());
    });

    // состояние страницы: выбор категории тура
    function state_select_tour_category(tour_type_id) {
        $.ajax({
            type: 'POST',
            url: '/api/tour_type_categories',
            data: { 'tour_type_id': tour_type_id },
            success: function(msg) { // если запрос успешен - рендерим селект с категориями
               // console.log(msg);
                $('#category_select_area').empty();
                $('#category_select_area').append('<label>Категория</label>');
                $('#category_select_area').append('<select id="seo_data_item_tour_category_id" name="seo_data_item[tour_category_id]"></select>');
                $('#seo_data_item_tour_category_id').append('<option value="">Не выбрана</option>');

                for (let category of msg) {
                    $('#seo_data_item_tour_category_id').append('<option value="' + category.id + '">' + category.title_ru + '</option>');
                }

                $('#seo_data_item_tour_category_id').selectize({});
            }

        });
    }
}