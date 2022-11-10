I18n.pluralization["ru"] = function (count) {
  var key = count % 10 === 1 && count % 100 !== 11 ? "one" : [2, 3, 4].indexOf(count % 10) >= 0 && [12, 13, 14].indexOf(count % 100) < 0 ? "few" : count % 10 == 0 || [5, 6, 7, 8, 9].indexOf(count % 10) >= 0 || [11, 12, 13, 14].indexOf(count % 100) >= 0 ? "many" : "other";
  return [key];
};

$(document).ready(function () {
  $('#dataTable').DataTable();

  // генерация селекта плагина selectize.js с одной опцией выбора
  $('.selectize-one-option').selectize({
    persist: false,
    createOnBlur: true,
    create: true
  });

  $(".tabs").lightTabs();
});

(function ($) {
  $(document).ajaxSend(function (e, xhr, options) {
    var token = $('meta[name="csrf-token"]').attr('content');
    if (token) xhr.setRequestHeader('X-CSRF-Token', token);
  });
})(jQuery);


$(document).ready(function () {
  $(".tabs").lightTabs();

  $(document).ajaxStart(function () {
    $('[data-loader="circle-side"]').fadeIn();
    $('#preloader').fadeIn();

    console.log('global start');
  }).ajaxComplete(function () {
    $('#preloader').fadeOut();
    $('[data-loader="circle-side"]').fadeOut();
    // window.location.reload();

    // console.log('global complete');
  });

  $("form.remote")
    .on("submit", function () {
      $('[data-loader="circle-side"]').fadeIn();
      $('#preloader').fadeIn();

      // console.log('form submit');
    });
  $(".remote")
    .on("ajax:start", function () {
      $('[data-loader="circle-side"]').fadeIn();
      $('#preloader').fadeIn();

      // console.log('start');
    })
    .on("ajax:complete", function () {
      $('#preloader').fadeOut();
      $('[data-loader="circle-side"]').fadeOut();
      window.location.reload();

      // console.log('complete');
    })
    .on("ajax:success", function (event) {
      [data, status, xhr] = event.detail;
      $(this).find('.form-control').removeClass('is-invalid');
      $(this).find('.selectize-input').removeClass('border border-danger');
      if (data.redirect !== undefined && data.redirect != null && data.redirect !== '')
        window.location = data.redirect;
      if (data.refresh !== undefined && data.refresh != null && data.refresh !== '')
        $.getScript(data.refresh);
      // alert('Ok');
      // console.log('success');

    }).on("ajax:error", function (event) {
    $(this).find('.form-control').removeClass('is-invalid');
    $(this).find('.selectize-input').removeClass('border border-danger');
    [data, status, xhr] = event.detail;
    var err_txt = "";
    for (object in data.errors)
      for (input in data.errors[object]) {
        var inp = $(this).find('#' + object + '_' + input + '.form-control');
        if (inp.length > 0)
          $(inp).addClass('is-invalid');
        else
          var sel = $(this).find('select#' + object + '_' + input).parent().find('.selectize-input');
        if (sel.length > 0)
          $(sel).addClass('border border-danger');
        else {
          console.log('error: ', data.errors[object][input].join(','));
          err_txt = ' ' + err_txt + data.errors[object][input].join(',');
        }
      }
    alert('check errors' + err_txt);
  });
});