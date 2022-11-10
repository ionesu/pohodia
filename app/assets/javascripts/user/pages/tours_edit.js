// страница редактирования тура
// /guides/tours/:id/edit

if (document.body.className.match('tours-edit') ) {

    // группа зависимых селектов тип тура -> категория тура
    $("#tour_tour_type_id").change(function() {
        $.ajax({
            type: 'POST',
            url: '/api/tour_type_categories',
            data: { 'tour_type_id': $(this).val() },
            success: function(msg) { // если запрос успешен - рендерим селект с категориями
                // console.log(msg);
                $('#category_select_area').empty();
                $('#category_select_area').append('<label>' + I18n.t('models.tour.tour_category') + '</label>');
                $('#category_select_area').append('<select id="tour_tour_category_id" name="tour[tour_category_id]"></select>');
                $('#tour_tour_category_id').append('<option value="">' + I18n.t('all_pages.labels.no_selected_v2') + '</option>');

                for (let category of msg) {
                    $('#tour_tour_category_id').append('<option value="' + category.id + '">' + category.title_ru + '</option>');
                }

                $('#tour_tour_category_id').selectize({});
            }
        });
    });

}