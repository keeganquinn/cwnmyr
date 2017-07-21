/* global google */

function displayMap (data) {
  if (!data.nodes || !data.nodes.values) {
    return
  }

  var mapDiv = document.getElementById('map')
  var gMap = new google.maps.Map(mapDiv, {
    maxZoom: 18,
    minZoom: 11,
    zoom: 17
  })
  var bounds = new google.maps.LatLngBounds()
  var infoWindow = new google.maps.InfoWindow()

  for (let node of data.nodes.values()) {
    if (!node.lat || !node.lng) {
      continue
    }
    bounds.extend(new google.maps.LatLng(node.lat, node.lng))
    let marker = new google.maps.Marker({
      map: gMap,
      position: new google.maps.LatLng(node.lat, node.lng),
      title: node.name
    })
    marker.addListener('click', function () {
      infoWindow.setContent(node.infowindow)
      infoWindow.open(gMap, marker)
    })
  }
  gMap.fitBounds(bounds)
  gMap.panToBounds(bounds)

  function displayPosition (position) {
    var marker = new google.maps.Marker({
      icon: require('!file-loader!images/position_small.png'),
      map: gMap,
      position: new google.maps.LatLng(
        position.coords.latitude, position.coords.longitude)
    })
    marker.addListener('click', function () {
      infoWindow.setContent('You Are Here')
      infoWindow.open(gMap, marker)
    })
    if (mapDiv.dataset.center) {
      gMap.setCenter(marker.position)
    }
  }

  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(displayPosition)
  }
}

function handleError (error) {
  console.log(error.responseText)
}

function initMap () {
  var mapDiv = document.getElementById('map')
  if (!mapDiv) {
    return
  }

  var xmlhttp = new XMLHttpRequest()
  xmlhttp.onreadystatechange = function () {
    if (xmlhttp.readyState === XMLHttpRequest.DONE) {
      if (xmlhttp.status === 200) {
        displayMap(JSON.parse(xmlhttp.responseText))
      } else {
        handleError(xmlhttp)
      }
    }
  }
  xmlhttp.open('GET', mapDiv.dataset.markers, true)
  xmlhttp.send()
}

window.initMap = initMap
