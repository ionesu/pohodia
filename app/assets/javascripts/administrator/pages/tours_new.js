// страница добавления тура
// /administrators/tours/new

if (document.body.className.match('tours-new')) {

  $("#tour_country_id").change(function () {
    state_select_region($(this).val());
    state_cities_without_regions($(this).val());
  });

  // состояние страницы: выбор региона
  function state_select_region(country_id) {
    $.ajax({
      type: 'POST',
      url: '/api/country_regions',
      data: {
        'country_id': country_id,
      },
      success: function (msg) { // если запрос успешен - рендерим селект с регионами
        clear_region_area();

        for (let region of msg) {
          $('#tour_region_id').append('<option value="' + region.id + '">' + region.title_ru + '</option>');
        }

        $('#tour_region_id').selectize({
          onChange: function (value) {
            state_select_city(value);
          }
        });
      }

    });
  }

  /**
   * Выбор города без региона
   * @param country_id
   */
  function state_cities_without_regions(country_id) {
    $.ajax({
      type: 'GET',
      url: '/cities.json',
      data: {
        'country_id': country_id
      },
      success: response => {
        clear_city_area();

        for (let city of response) {
          $('#tour_city_id').append('<option value="' + city.id + '" name="guide[city_id]">' + city.title_ru + '</option>');
        }

        $('#tour_city_id').selectize({});
      }
    })
  }

  // состояние страницы: выбор города
  function state_select_city(region_id) {
    $.ajax({
      type: 'POST',
      url: '/api/region_cities',
      data: {
        'region_id': region_id,
      },
      success: function (msg) { // если запрос успешен - рендерим селект с городами
        //  console.log(msg);
        clear_city_area();

        for (let city of msg) {
          $('#tour_city_id').append('<option value="' + city.id + '" name="tour[city_id]">' + city.title_ru + '</option>');
        }

        $('#tour_city_id').selectize({});
      }

    });
  }

  function clear_region_area() {
    $('#region_select_area').empty();
    $('#region_select_area').append('<label>Регион</label>');
    $('#region_select_area').append('<select id="tour_region_id" name="tour[region_id]"></select>');
    $('#tour_region_id').append('<option value="">Не выбран</option>');
  }

  function clear_city_area(selectize) {
    $('#city_select_area').empty();
    $('#city_select_area').append('<label>Город</label>');
    $('#city_select_area').append('<select id="tour_city_id" name="tour[city_id]"></select>');
    $('#tour_city_id').append('<option value="">Не выбран</option>');
    if (selectize == true) {
      $('#tour_city_id').selectize({});
    }
  }

  // слайдер сложности
  // $("#tour_complexity").ionRangeSlider({
  //     hide_min_max: true,
  //     keyboard: true,
  //     min: 1,
  //     max: 5,
  //     from: 0,
  //     to: 700,
  //     type: 'single',
  //     step: 1,
  //     prefix: "Сложность ",
  //     grid: false
  // });
  // слайдер мин/макс высота
  // $("#range2").ionRangeSlider({
  //     hide_min_max: true,
  //     keyboard: true,
  //     min: -2000,
  //     max: 8000,
  //     from: 0,
  //     to: 700,
  //     type: 'double',
  //     step: 1,
  //     postfix: " м",
  //     prettify_enabled: true,
  //     grid: false
  // });
  // слайдер "длинна маршрута"
  // $("#tour_length_of_route").ionRangeSlider({
  //     hide_min_max: true,
  //     keyboard: true,
  //     min: 1,
  //     max: 2000,
  //     from: 1,
  //     to: 150,
  //     type: 'single',
  //     step: 1,
  //     postfix: " км",
  //     grid: false
  // });

  $("#tour_tour_type_id").change(function () {
    $.ajax({
      type: 'POST',
      url: '/api/tour_type_categories',
      data: {'tour_type_id': $(this).val()},
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
  });

}