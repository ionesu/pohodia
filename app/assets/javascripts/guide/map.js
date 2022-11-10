var accessToken = 'pk.eyJ1IjoibWFyazUxMzciLCJhIjoiY2p2ZTM3anJ5MGIwNjRlcGF3YjAyMnpzNCJ9.cJz-M--V3NMcBA9cAYaigA';

function extracted() {
  var mymap = L.map('mapid').setView([51.505, -0.09], 3);

  var onClickCallback = function(point) {
    $("#tour_route_geo_latitude[data-tour-route-id='new']").val(point.latlng.lat);
    $("#tour_route_geo_longitude[data-tour-route-id='new']").val(point.latlng.lng);
  };

  L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=' + accessToken, {
    attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
    maxZoom: 36,
    id: 'mapbox.streets',
    accessToken: 'your.mapbox.access.token'
  }).addTo(mymap);

  mymap.on('click', onClickCallback);
}

extracted();

function mapForRoutePoints(elementId) {
  var map = L.map(elementId).setView([51.505, -0.09], 3);
 
  var onClickCallback = function(point) {
    var tourRouteId = elementId.replace('mappoints-', '');

    $.ajax({
      type: 'POST',
      url: '/guides/tour_routes/' + tourRouteId + '/tour_route_points',
      data: {
        tour_route_point: {
          geo_latitude: point.latlng.lat,
          geo_longitude: point.latlng.lng
        }
      },
      success: function(tourRoutePoint) {
        console.log(tourRoutePoint);
        var content = '<div class="border my-3 p-2">' + tourRoutePoint.geo_latitude + ', ' + tourRoutePoint.geo_longitude;
        var content = content + '<a class="remote float-right" data-remote="true" rel="nofollow" data-method="delete" href="/guides/tour_routes/' + tourRoutePoint.tour_route_id + '/tour_route_points/' + tourRoutePoint.id + '">✘</a>'
        var content = content + '</div>';
        $('#points-' + tourRouteId).append(content);
      }
    })
  };

  L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=' + accessToken, {
    attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
    maxZoom: 36,
    id: 'mapbox.streets',
    accessToken: 'your.mapbox.access.token'
  }).addTo(map);
  
  map.on('click', onClickCallback);
}

$('.mapref').each(function(index, element) {
  mapForRoutePoints(element.id);
});

$('.delete_all_points').click(function(event) {
  var tourRouteId = event.target.getAttribute('data-route-id');

  $.ajax({
    type: 'DELETE',
    url: '/guides/tour_routes/' + tourRouteId + '/tour_route_points',
    success: function() {
      window.location.reload();
    }
  });
});