// страница редактирования тура
// /administrators/tours/:id/edit

if (document.body.className.match('tours-edit')) {
  $("#tour_tour_type_id").change(function () {
    state_select_tour_category($(this).val());
  });

  // состояние страницы: выбор категории тура
  function state_select_tour_category(tour_type_id) {
    $.ajax({
      type: 'POST',
      url: '/api/tour_type_categories',
      data: {'tour_type_id': tour_type_id},
      success: function (msg) { // если запрос успешен - рендерим селект с категориями
        // console.log(msg);
        $('#category_select_area').empty();
        $('#category_select_area').append('<label>Категория</label>');
        $('#category_select_area').append('<select id="tour_tour_category_id" name="tour[tour_category_id]"></select>');
        $('#tour_tour_category_id').append('<option value="">Не выбрана</option>');

        for (let category of msg) {
          $('#tour_tour_category_id').append('<option value="' + category.id + '">' + category.title_ru + '</option>');
        }

        $('#tour_tour_category_id').selectize({});
      }
    });
  }

  $('input.date-pick').datepicker();
}