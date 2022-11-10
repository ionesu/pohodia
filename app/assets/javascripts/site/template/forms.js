$(document).ready(function () {

  // $(document).ajaxStart(function () {
  //   $('[data-loader="circle-side"]').fadeIn();
  //   $('#preloader').fadeIn();
  // })
  //   .ajaxComplete(function (event, request, settings) {
  //     $('#preloader').fadeOut();
  //     $('[data-loader="circle-side"]').fadeOut();
  //   });

  $('.booking_button').on('click', function () {
    var that = $(this).closest('li').next('.booking_form');
    $('.booking_form').each(function () {
      if (that.is(this))
        $(this).toggle();
      else
        $(this).hide();
    });
    return false;
  });

  $("form.booking")
    .on("submit", function () {
      $('[data-loader="circle-side"]').fadeIn();
      $('#preloader').fadeIn();
    });
  $("form.booking")
    .on("ajax:start", function () {
      $('[data-loader="circle-side"]').fadeIn();
      $('#preloader').fadeIn();
    })
    .on("ajax:complete", function () {
      $('#preloader').fadeOut();
      $('[data-loader="circle-side"]').fadeOut();
    })
    .on("ajax:success", function (event) {
      [data, status, xhr] = event.detail;
      $(this).hide();
      alert('Booked');
      location.reload();
      //console.log('success');
    }).on("ajax:error", function (event) {
    //$(this).find('.form-control').removeClass('is-invalid');
    //$(this).find('.selectize-input').removeClass('border border-danger');
    [data, status, xhr] = event.detail;
    var err_txt = "";
    for (object in data.errors) {
      err_txt = ' ' + err_txt + data.errors[object].join(', ');
    }
    alert('failed with errors:' + err_txt);
  });
});