$(document).ready(function() {
    $('#dataTable').DataTable();

    // генерация селекта плагина selectize.js с одной опцией выбора
    $('.selectize-one-option').selectize({
        persist: false,
        createOnBlur: true,
        create: true
    });
});


(function($) {
    $(document).ajaxSend(function(e, xhr, options) {
        var token = $('meta[name="csrf-token"]').attr('content');
        if (token) xhr.setRequestHeader('X-CSRF-Token', token);
    });
})(jQuery);