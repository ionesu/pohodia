var $tourIsotope = $('.isotope-tours');
$tourIsotope.isotope({
  itemSelector: '.isotope-tour', layoutMode: 'masonry'
});

function isPresent(value) {
  if (value === undefined || value === '') {
    return false;
  } else {
    return true;
  }
}

$('.passport-search-button').click(function() {
  var search = $('.passport-search').val();
  var country = $('.passport-country').val();
  var category = $('.passport-category').val();

  $tourIsotope.isotope({
    filter: function() {
      if (isPresent(search)) {
        var source = $(this).find('.isotope-tour-name').text();
        var searchTerm = (source.toLowerCase().indexOf(search.toLowerCase()) !== -1);
      } else {
        var searchTerm = true;
      }

      if (isPresent(country)) {
        var source = $(this).data('country');
        var countryTerm = (source.toLowerCase().indexOf(country.toLowerCase()) !== -1);
      } else {
        var countryTerm = true;
      }

      if (isPresent(category)) {
        if (category == 'Все' || category == 'All') {
          var categoryTerm = true;
        } else {
          var source = $(this).data('category');
          var categoryTerm = (source == category);
        }
      } else {
        var categoryTerm = true;
      }

      return (searchTerm && countryTerm && categoryTerm);
    }
  });
});

//****************************
// Isotope Load more button
//****************************
var initShow = 3; //number of items loaded on init & onclick load more button
var counter = initShow; //counter for load more button
var iso = $tourIsotope.data('isotope'); // get Isotope instance

if (iso) loadMore(initShow);

function loadMore(toShow) {
  $tourIsotope.find('.hidden').removeClass('hidden');

  var hiddenElems = iso.filteredItems.slice(toShow, iso.filteredItems.length).map(function(item) {
    return item.element;
  });
  $(hiddenElems).addClass('hidden');
  $tourIsotope.isotope('layout');

  //when no more to load, hide show more button
  if (hiddenElems.length == 0) {
    jQuery("#load-more").hide();
  } else {
    jQuery("#load-more").show();
  };
}

//append load more button
$tourIsotope.after('<p class="text-center"><a href="#0" id="load-more" class="btn_1 rounded add_top_30">Load more</a></p>');

//when load more button clicked
$("#load-more").click(function() {
  if ($('#filters').data('clicked')) {
    counter = initShow;
    $('#filters').data('clicked', false);
  } else {
    counter = counter;
  };
  counter = counter + initShow;
  loadMore(counter);
});

//when filter button clicked
$("#filters").click(function() {
  $(this).data('clicked', true);
  loadMore(initShow);
});
