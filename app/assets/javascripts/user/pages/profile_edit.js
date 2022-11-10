// страница редактирования профиля гида
// /guides/edit_profile

if (document.body.className.match('profile-edit')) {

  $("#guide_country_id").change(function () {
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
          $('#guide_region_id').append('<option value="' + region.id + '">' + region.title_ru + '</option>');
        }

        $('#guide_region_id').selectize({
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
          $('#guide_city_id').append('<option value="' + city.id + '" name="guide[city_id]">' + city.title_ru + '</option>');
        }

        $('#guide_city_id').selectize({});
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
          $('#guide_city_id').append('<option value="' + city.id + '" name="guide[city_id]">' + city.title_ru + '</option>');
        }

        $('#guide_city_id').selectize({});
      }

    });
  }

  function clear_region_area() {
    $('#region_select_area').empty();
    $('#region_select_area').append('<label>' + I18n.t('models.tour.region') + '</label>');
    $('#region_select_area').append('<select id="guide_region_id" name="guide[region_id]"></select>');
    $('#guide_region_id').append('<option value="">' + I18n.t('all_pages.labels.no_selected') + '</option>');
  }

  function clear_city_area(selectize) {
    $('#city_select_area').empty();
    $('#city_select_area').append('<label>' + I18n.t('models.tour.city') + '</label>');
    $('#city_select_area').append('<select id="guide_city_id" name="guide[city_id]"></select>');
    $('#guide_city_id').append('<option value="">' + I18n.t('all_pages.labels.no_selected') + '</option>');
    if (selectize == true) {
      $('#guide_city_id').selectize({});
    }
  }

}