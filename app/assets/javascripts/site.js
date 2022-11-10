// require rails-ujs
// require site/template/jquery-2.2.4.min
//= require jquery

//= require site/common_scripts

//= require jquery-ui/widgets/autocomplete

//= require site/template/common_scripts

//= require site/template/validate
//= require site/template/video_header
//= require site/template/modernizr
// require site/template/infobox
// require site/template/map_tours
//= require site/template/isotope.min
//= require site/template/icheck
//= require site/template/main
//= require site/template/filter

//= require site/template/forms

//= require guide/template/selectize

// мультиязычность
//= require i18n
//= require i18n/translations
//= require vendor/set_locale

//= require_tree ./site/pages

//= require vendor/moment.min
//= require vendor/daterangepicker
//= require site/tours/index
//= require site/tours/country_region

//= require leaflet
//= require site/tours/map

//= require site/passport/isotope.js

I18n.pluralization["ru"] = function (count) {
  var key = count % 10 == 1 && count % 100 != 11 ? "one" : [2, 3, 4].indexOf(count % 10) >= 0 && [12, 13, 14].indexOf(count % 100) < 0 ? "few" : count % 10 == 0 || [5, 6, 7, 8, 9].indexOf(count % 10) >= 0 || [11, 12, 13, 14].indexOf(count % 100) >= 0 ? "many" : "other";
  return [key];
};


(function ($) {
  $(document).ajaxSend(function (e, xhr, options) {
    var token = $('meta[name="csrf-token"]').attr('content');
    if (token) xhr.setRequestHeader('X-CSRF-Token', token);
  });
})(jQuery);

$(document).ready(function () {
  // генерация селекта плагина selectize.js с одной опцией выбора
  $('.selectize-one-option').selectize({
    persist: false,
    createOnBlur: true,
    create: true
  });

  // всплывающее окно "функционал в разработке"
  $('.popup-content').magnificPopup({
    type: 'inline'
  });

  if ($('.header-video').length > 0)
    HeaderVideo.init({
      container: $('.header-video'),
      header: $('.header-video--media'),
      videoTrigger: $("#video-trigger"),
      autoPlayVideo: true
    });
});

$('.icheck input').iCheck({
  handle: 'checkbox'
});

// Check and radio input styles
$('input.icheck').iCheck({
  checkboxClass: 'icheckbox_square-grey',
  radioClass: 'iradio_square-grey'
});

// Atltenative checkbox styles - Switchery
var elems = Array.prototype.slice.call(document.querySelectorAll('.js-switch'));
elems.forEach(function (html) {
  var switchery = new Switchery(html, {
    size: 'small'
  });
});

/**
 * Ограничение, нельзя прикладывать более, чем 10 файлов в отзыве о туре
 */
$("input[type='submit']").click(function (e) {
  var $fileUpload = $("input[type='file']");
  if (parseInt($fileUpload.get(0).files.length) > 10) {
    alert("Нельзя прикладывать больше 10 файлов");
    e.preventDefault();
    return false;
  }
});

$('input.icheck').iCheck({
  checkboxClass: 'icheckbox_square-grey',
  radioClass: 'iradio_square-grey'
});

// Используется на странице гида, компании
$(document).ready(function() {
  console.log('dasda');
  $('.wide').niceSelect();
});
