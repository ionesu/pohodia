/**
 * Страница редактирование профиля
 * Установка городов, регионов, стран
 */
$('#country_id').change(function () {
  state_select_region($(this).val());
  state_cities_without_regions($(this).val());
});

$('#tour_filter_region_id').change(function () {
  state_select_city($(this).val());
});

/**
 * Выбор региона
 * @param country_id
 */
function state_select_region(country_id) {
  $.ajax({
    type: 'GET',
    url: '/regions.json',
    data: {
      'country_id': country_id,
    },
    success: response => {
      clear_region_area();

      for (let region of response) {
        $('#redion_id').append('<option value="' + region.id + '">' + region.title_ru + '</option>');
      }

      $('#redion_id').selectize({
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
        $('#city_id').append('<option value="' + city.id + '" name="guide[city_id]">' + city.title_ru + '</option>');
      }

      $('#city_id').selectize({});
    }
  })
}

/**
 * Выбор города, если выбран регион
 * @param region_id
 */
function state_select_city(region_id) {
  $.ajax({
    type: 'GET',
    url: '/cities.json',
    data: {
      'region_id': region_id,
    },
    success: response => {
      clear_city_area();

      for (let city of response) {
        $('#city_id').append('<option value="' + city.id + '" name="guide[city_id]">' + city.title_ru + '</option>');
      }

      $('#city_id').selectize({});
    }

  });
}

function clear_region_area() {
  $('#region_select_area').empty();
  $('#region_select_area').append('<select id="redion_id" name="tour_filter[region_id]"></select>');
  $('#redion_id').append('<option value="">' + I18n.t('all_pages.labels.no_selected') + '</option>');
}

function clear_city_area(selectize) {
  $('#city_select_area').empty();
  $('#city_select_area').append('<select id="city_id" name="tour_filter[city_id]"></select>');
  $('#city_id').append('<option value="">' + I18n.t('all_pages.labels.no_selected') + '</option>');
  if (selectize === true) {
    $('#city_id').selectize({});
  }
}