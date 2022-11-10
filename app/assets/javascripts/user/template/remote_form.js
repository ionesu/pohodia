
I18n.pluralization["ru"] = function (count) {
  var key = count % 10 == 1 && count % 100 != 11 ? "one" : [2, 3, 4].indexOf(count % 10) >= 0 && [12, 13, 14].indexOf(count % 100) < 0 ? "few" : count % 10 == 0 || [5, 6, 7, 8, 9].indexOf(count % 10) >= 0 || [11, 12, 13, 14].indexOf(count % 100) >= 0 ? "many" : "other";
  return [key];
};

// useless?
//$.ajaxSetup({ dataType: 'json' });

$(document).ready(function(){
  
  $(".tabs").lightTabs();
  
  $( document ).ajaxStart(function() {
    $('[data-loader="circle-side"]').fadeIn();
      $('#preloader').fadeIn();
      console.log('global start');
    })
    .ajaxComplete(function( event, request, settings ) {
      $('#preloader').fadeOut();
      $('[data-loader="circle-side"]').fadeOut();
      console.log('global complete');
    });
  $("form.remote")
    .on("submit", function(){
      $('[data-loader="circle-side"]').fadeIn();
      $('#preloader').fadeIn();
      console.log('form submit');
    });
  $(".remote")
    .on("ajax:start", function(){
      $('[data-loader="circle-side"]').fadeIn();
      $('#preloader').fadeIn();
      console.log('start');
    })
    .on("ajax:complete", function(){
      $('#preloader').fadeOut();
      $('[data-loader="circle-side"]').fadeOut();
      console.log('complete');
    })
    .on("ajax:success", function(event){
      [data, status, xhr] = event.detail;    
      $(this).find('.form-control').removeClass('is-invalid');
      $(this).find('.selectize-input').removeClass('border border-danger');    
      if(data.redirect != undefined && data.redirect != null && data.redirect != '')
        window.location = data.redirect;
      if(data.refresh != undefined && data.refresh != null && data.refresh != '')
        $.getScript( data.refresh );
      //alert('Ok');
      console.log('success');
    }).on("ajax:error", function(event){
      $(this).find('.form-control').removeClass('is-invalid');
      $(this).find('.selectize-input').removeClass('border border-danger');    
      [data, status, xhr] = event.detail;    
      for (object in data.errors) 
        for (input in data.errors[object]) {
          $(this).find('#'+object+'_'+input+'.form-control').addClass('is-invalid');
          $(this).find('select#'+object+'_'+input).parent().find('.selectize-input').addClass('border border-danger');
        }        
      console.log('error');
      alert('check errors');
    });
});