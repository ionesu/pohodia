//= require rails-ujs
//= require jquery

// мультиязычность
//= require i18n
//= require i18n/translations
//= require vendor/set_locale

//= require guide/template/jquery.min
//= require guide/template/bootstrap.bundle.min
//= require guide/template/jquery.easing.min
//= require vendor/jquery.dataTables
//= require guide/template/dataTables.bootstrap4
//= require guide/template/admin
//= require guide/template/selectize
//= require guide/template/ion.rangeSlider

// кастомные плагины
//= require guide/plugins/tabs

//= require_tree ./guide/pages
//= require guide/template/remote_form

//= require leaflet
//= require guide/map

$('.comment-update').click(function () {
  window.location.reload();
});

$('.comment-destroy').click(function () {
  window.location.reload();
});
