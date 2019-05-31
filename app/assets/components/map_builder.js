/* global google */

class MapBuilder {
  constructor () {
    this.gBounds = null
    this.gInfoWindow = null
    this.gMap = null
    this.mapDiv = null
    this.statusCtrl = null
    this.errors = []
  }

  initMap () {
    this.mapDiv = document.getElementById('map')
    if (!this.mapDiv) {
      return false
    }

    let request = new XMLHttpRequest()
    let me = this
    request.onreadystatechange = function () {
      if (request.readyState === XMLHttpRequest.DONE) {
        if (request.status === 200) {
          me.handleResponse(JSON.parse(request.responseText))
        } else {
          me.handleError(request)
        }
      }
    }
    request.open('GET', this.mapDiv.dataset.markers, true)
    request.send()
  }

  handleError (error) {
    this.errors.push(error)
  }

  handleResponse (data) {
    this.gBounds = new google.maps.LatLngBounds()
    this.gInfoWindow = new google.maps.InfoWindow()
    this.gMap = new google.maps.Map(this.mapDiv, {
      maxZoom: 18,
      minZoom: 12,
      zoom: 17
    })

    this.statusCtrl = document.createElement('div')
    this.statusCtrl.style.background = '#fff'
    this.statusCtrl.style.border = '1px solid #000'
    this.statusCtrl.style.padding = '2px'

    let me = this
    let showBtn = document.createElement('input')
    showBtn.setAttribute('type', 'button')
    showBtn.setAttribute('value', 'show all')
    showBtn.onclick = function () {
      let boxes = me.statusCtrl.querySelectorAll('input[type="checkbox"]')
      for (let box of boxes) {
        if (!box.checked) {
          box.checked = true
          box.onchange()
        }
      }
    }

    let hideBtn = document.createElement('input')
    hideBtn.setAttribute('type', 'button')
    hideBtn.setAttribute('value', 'hide all')
    hideBtn.onclick = function () {
      let boxes = me.statusCtrl.querySelectorAll('input[type="checkbox"]')
      for (let box of boxes) {
        if (box.checked) {
          box.checked = false
          box.onchange()
        }
      }
    }

    this.statusCtrl.append(showBtn)
    this.statusCtrl.append(hideBtn)
    this.statusCtrl.append(document.createElement('br'))

    if (navigator.geolocation) {
      // Disable user geolocation; it is annoying and unhelpful as a default.
      // This should be reimplemented as a configurable option.
      // navigator.geolocation.getCurrentPosition(this.handlePosition)
    }

    if (data.node) {
      this.renderNode(data.node)
    } else if (data.statuses) {
      window.addEventListener('orientationchange', this.handleResize.bind(this))
      window.addEventListener('resize', this.handleResize.bind(this))
      this.handleResize()

      for (let status of data.statuses) {
        this.renderStatus(status)
      }
      this.gMap.controls[google.maps.ControlPosition.TOP_RIGHT].push(
        this.statusCtrl)
    } else if (data.zone && data.zone.statuses) {
      window.addEventListener('orientationchange', this.handleResize.bind(this))
      window.addEventListener('resize', this.handleResize.bind(this))
      this.handleResize()

      for (let status of data.zone.statuses) {
        this.renderStatus(status)
      }
      this.gMap.controls[google.maps.ControlPosition.TOP_RIGHT].push(
        this.statusCtrl)
    }

    this.gMap.fitBounds(this.gBounds)
    this.gMap.panToBounds(this.gBounds)
  }

  handleResize (event) {
    if (!this.mapDiv) return

    this.mapDiv.style.height = `${window.innerHeight - 56}px`
    window.scrollTo(0, 0)
  }

  handlePosition (position) {
    let me = this
    me.posMarker = new google.maps.Marker({
      icon: 'position_small.png',
      map: this.gMap,
      position: new google.maps.LatLng(
        position.coords.latitude, position.coords.longitude),
      title: 'Current Location'
    })
    me.posMarker.addListener('click', function () {
      me.gInfoWindow.setContent('You Are Here')
      me.gInfoWindow.open(me.gMap, me.posMarker)
    })
    if (this.mapDiv.dataset.center) {
      this.gMap.setCenter(me.posMarker.position)
    }
  }

  renderStatus (status) {
    let me = this

    let statusBox = document.createElement('input')
    statusBox.setAttribute('type', 'checkbox')
    let layer = new google.maps.MVCObject()
    statusBox.onchange = function () {
      layer.set('map', this.checked ? me.gMap : null)
    }
    statusBox.checked = status.default_display
    statusBox.onchange()

    let statusLabel = document.createElement('span')
    statusLabel.setAttribute('style', 'color: ' + status.color + ';')
    statusLabel.append(status.name)

    let statusDiv = document.createElement('div')
    statusDiv.append(statusBox)
    statusDiv.append(' ')
    statusDiv.append(statusLabel)

    this.statusCtrl.append(statusDiv)

    for (let node of status.nodes) {
      let marker = this.renderNode(node)
      if (marker) {
        marker.bindTo('map', layer, 'map')
      }
    }
  }

  renderNode (node) {
    if (!node.lat || !node.lng) {
      return false
    }

    let me = this
    let marker = new google.maps.Marker({
      icon: node.icon,
      map: this.gMap,
      position: new google.maps.LatLng(node.lat, node.lng),
      title: node.name
    })
    marker.addListener('click', function () {
      me.gInfoWindow.setContent(node.infowindow)
      me.gInfoWindow.open(me.gMap, marker)
    })
    this.gBounds.extend(marker.position)

    return marker
  }
}

export { MapBuilder }
