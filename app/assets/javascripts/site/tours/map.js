function connectTheDots(tourRoutePoints) {
  var c = [];
  tourRoutePoints.forEach(function (element) {
    var x = element.geo_latitude;
    var y = element.geo_longitude;
    c.push([x, y]);
  });
  return c;
}

function centerTheDots(routes) {
  var x0 = Number(routes[0].geo_latitude);
  var y0 = Number(routes[0].geo_longitude);

  var lastElement = routes.length - 1;
  var x1 = Number(routes[lastElement].geo_latitude);
  var y1 = Number(routes[lastElement].geo_longitude);

  var x = (x0 + x1) / 2;
  var y = (y0 + y1) / 2;
  return [x, y];
}

function tourRoutesMap() {
  var accessToken = 'pk.eyJ1IjoibWFyazUxMzciLCJhIjoiY2p2ZTM3anJ5MGIwNjRlcGF3YjAyMnpzNCJ9.cJz-M--V3NMcBA9cAYaigA';

  var tourId = $('#mapid').data('tour-id');

  if (tourId === undefined) {
    return;
  }

  $.ajax({
    type: 'GET',
    url: '/tours/' + tourId + '/tour_routes.json',
    success: function (tourRoutes) {
      var center = centerTheDots(tourRoutes);

      var map = L.map('mapid').setView([center[0], center[1]], 5);
      L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=' + accessToken, {
        attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
        maxZoom: 32,
        id: 'mapbox.streets',
        accessToken: 'your.mapbox.access.token'
      }).addTo(map);

      var tourRoutePoints = [];
      tourRoutes.forEach(function (tourRoute) {
        tourRoute.tour_route_points.forEach(function (tourRoutePoint) {
          tourRoutePoints.push(tourRoutePoint);
        })
      });

      if (tourRoutePoints.length > 1) {
        var fg = L.featureGroup().addTo(map);
        tourRoutePoints.forEach(function (element) {
          L.marker([element.geo_latitude, element.geo_longitude]).addTo(fg);
        });
        map.fitBounds(fg.getBounds());
      } else {
        var element = tourRoutePoints[0];
        L.marker([element.geo_latitude, element.geo_longitude]).addTo(map);
      }

      if (tourRoutePoints.length > 1) {
        var pathCoords = connectTheDots(tourRoutePoints);
        L.polyline(pathCoords).addTo(map);
      }
    }
  })
}

tourRoutesMap();
