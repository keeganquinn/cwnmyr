/* global Gmaps */

function displayMap (data) {
  var handler = Gmaps.build('Google')
  handler.buildMap({internal: {id: 'map'}}, function () {
    var markers = handler.addMarkers(data)
    handler.bounds.extendWith(markers)
    handler.fitMapToBounds()
  })
}

function handleError (error) {
  console.log(error.responseText)
}

$(document).ready(function () {
  var mapDiv = $('#map')
  if (!mapDiv.length) {
    return
  }

  var node = mapDiv.data('node')
  var path = null
  if (node) {
    path = '/nodes/' + node + '/markers'
  } else {
    var zone = mapDiv.data('zone')
    path = '/zones/' + zone + '/markers'
  }

  $.ajax({
    url: path,
    dataType: 'json'
  }).done(displayMap).fail(handleError)
})
