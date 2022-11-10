
var filters = {};

var fFilter = function() {
  for(filter in filters) {
    //console.log(filter, filters[filter], $(this).data());
    if($(this).data(filter) != undefined && $(this).data(filter) != null) {  
      var a = $(this).data(filter);          
      //var expression = 'return ' + 'a' + filters[filter];
      var expression = 'a' + filters[filter];
      //console.log(expression);
      var mul = eval(expression.toString());
      //var mul = new Function('a', expression.toString());
      //console.log(mul);
      if(mul == false) return false;
    }
  }
  return true;
};

String.prototype.toCamelCase = function(){
  return this.replace(/((-|_)[a-z])/g, function($1){return $1.toUpperCase();}).replace(/(-|_)/g,'').toString();
};

$(window).load(function(){
  
  var $isotope = $('.isotope-wrapper').isotope({ 
    //filter: selector,      
    layoutMode: 'vertical',      
    itemSelector: '.isotope-item'
  });
  
  $('.filters_input')
    .off('input change')  
    .on('input change', function(){      
      var val = $(this).val();
      if($(this).hasClass('escaped')) 
        val = "'"+val+"'";
      var name = $(this).attr('data-filter').toCamelCase();
      var op = $(this).attr('data-filter-op');
    console.log(name, op, val);
      if(val != undefined && val != null && val != '') {
        filters[name] = op + val;
      } else {
        delete filters[name];
      }
    //console.log(filters);
            
      //var filterValue = this.value;
      //filterValue = filterFns[ filterValue ] || filterValue;
      $isotope.isotope({ filter: fFilter });
    });    
    
});
