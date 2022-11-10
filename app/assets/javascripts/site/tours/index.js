$('.wish_bt').click(function () {
  $.ajax({
    type: 'POST',
    url: '/favorites',
    data: {
      'tour_id': this.dataset['tour_id'],
    },
    success: function () {
      console.log('Favorites adds')
    },
    error: function () {
      console.log('Favorites error!')
    }
  })
});

$(function () {
  $('.date-period').daterangepicker({
    autoUpdateInput: false,
    opens: 'right',
    locale: {
      "fromLabel": "С",
      "toLabel": "По",
      "daysOfWeek": [
        "Вс", "Пн", "Вт", "Ср", "Чт", "Пт", "Сб"
      ],
      "monthNames": [
        "Январь", "Февраль", "Март", "Апрель",
        "Май", "Июнь", "Июль", "Август",
        "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"
      ],
      cancelLabel: 'Очистить',
      applyLabel: 'Выбрать'
    }
  });

  $('.date-period').on('apply.daterangepicker', function (ev, picker) {
    $(this).val(picker.startDate.format('DD-MM-YYYY') + ' > ' + picker.endDate.format('DD-MM-YYYY'));
  });

  $('.date-period').on('cancel.daterangepicker', function () {
    $(this).val('');
  });
});