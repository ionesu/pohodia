/**
 * Выбор города
 */
$("#story_country_id").change(function () {
  state_select_region($(this).val());
  state_cities_without_regions($(this).val());
});

/**
 * Выбор региона
 * @param country_id
 */
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

/**
 * Выбор города
 */
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
  $('#region_select_area').append('<label>' + I18n.t('models.tour.region') + '</label>');
  $('#region_select_area').append('<select id="tour_region_id" name="tour[region_id]"></select>');
  $('#tour_region_id').append('<option value="">' + I18n.t('all_pages.labels.no_selected') + '</option>');
}

function clear_city_area(selectize) {
  $('#city_select_area').empty();
  $('#city_select_area').append('<label>' + I18n.t('models.tour.city') + '</label>');
  $('#city_select_area').append('<select id="tour_city_id" name="tour[city_id]"></select>');
  $('#tour_city_id').append('<option value="">' + I18n.t('all_pages.labels.no_selected') + '</option>');
  if (selectize == true) {
    $('#tour_city_id').selectize({});
  }
}