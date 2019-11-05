/* global google */

class MapBuilder {
  constructor() {
    this.elBtnHide = null;
    this.elBtnShow = null;
    this.elMap = null;
    this.elStatus = null;

    this.data = null;
    this.gBounds = null;
    this.gInfoWindow = null;
    this.gMap = null;
    this.markers = null;
  }

  prepare() {
    window.mapBuilder = this;
    window.addEventListener('orientationchange', this.handleResize.bind(this));
    window.addEventListener('resize', this.handleResize.bind(this));
  }

  initMap() {
    this.elMap = document.getElementById('map');
    if (!this.elMap) return;

    const request = new XMLHttpRequest();
    request.addEventListener('load', this.handleResponse);
    request.open('GET', this.elMap.dataset.markers, true);
    request.send();
  }

  get big() {
    return !!this.data.statuses;
  }

  handleResponse(event, data) {
    const { mapBuilder } = window;
    mapBuilder.data = data || JSON.parse(this.responseText);
    mapBuilder.renderMap();
  }

  renderMap() {
    this.markers = [];
    this.gBounds = new google.maps.LatLngBounds();
    this.gInfoWindow = new google.maps.InfoWindow();
    this.gMap = new google.maps.Map(this.elMap, {
      fullscreenControl: this.big,
      gestureHandling: this.big ? 'greedy' : 'cooperative',
      maxZoom: parseInt(this.elMap.dataset.maxZoom, 10) || 18,
      minZoom: parseInt(this.elMap.dataset.minZoom, 10) || 12,
      zoom: parseInt(this.elMap.dataset.zoom, 10) || 17,
    });

    this.elStatus = document.createElement('div');
    this.elStatus.style.background = '#fff';
    this.elStatus.style.border = '1px solid #000';
    this.elStatus.style.padding = '2px';

    this.elBtnShow = document.createElement('input');
    this.elBtnShow.setAttribute('type', 'button');
    this.elBtnShow.setAttribute('value', 'show all');
    this.elBtnShow.onclick = () => {
      const boxes = this.elStatus.querySelectorAll('input[type="checkbox"]');
      boxes.forEach((box) => {
        if (!box.checked) box.click();
      });
    };

    this.elBtnHide = document.createElement('input');
    this.elBtnHide.setAttribute('type', 'button');
    this.elBtnHide.setAttribute('value', 'hide all');
    this.elBtnHide.onclick = () => {
      const boxes = this.elStatus.querySelectorAll('input[type="checkbox"]');
      boxes.forEach((box) => {
        if (box.checked) box.click();
      });
    };

    this.elStatus.append(this.elBtnShow);
    this.elStatus.append(this.elBtnHide);
    this.elStatus.append(document.createElement('br'));

    if (navigator.geolocation) {
      // Disable user geolocation; it is annoying and unhelpful as a default.
      // This should be reimplemented as a configurable option.
      // navigator.geolocation.getCurrentPosition(this.handlePosition)
    }

    if (this.data.node) {
      this.renderNode(this.data.node);
    } else if (this.data.statuses) {
      this.data.statuses.forEach((status) => {
        this.renderStatus(status);
      });
      this.gMap.controls[google.maps.ControlPosition.TOP_RIGHT].push(
        this.elStatus,
      );
    } else if (this.data.zone && this.data.zone.statuses) {
      this.data.zone.statuses.forEach((status) => {
        this.renderStatus(status);
      });
      this.gMap.controls[google.maps.ControlPosition.TOP_RIGHT].push(
        this.elStatus,
      );
    }

    this.gMap.fitBounds(this.gBounds);
    this.gMap.panToBounds(this.gBounds);
    this.handleResize();
  }

  handleResize() {
    if (!this.elMap || !this.big) return;

    this.elMap.style.height = `${window.innerHeight - 56}px`;
    window.scrollTo(0, 0);
  }

  handlePosition(position) {
    this.posMarker = new google.maps.Marker({
      icon: 'position_small.png',
      map: this.gMap,
      position: new google.maps.LatLng(
        position.coords.latitude, position.coords.longitude,
      ),
      title: 'Current Location',
    });
    if (this.elMap.dataset.center) {
      this.gMap.setCenter(this.posMarker.position);
    }
  }

  renderStatus(status) {
    const statusBox = document.createElement('input');
    statusBox.setAttribute('type', 'checkbox');
    const layer = new google.maps.MVCObject();
    statusBox.onchange = () => {
      layer.set('map', statusBox.checked ? this.gMap : null);
    };
    statusBox.checked = status.default_display;
    statusBox.onchange();

    const statusLabel = document.createElement('span');
    statusLabel.setAttribute('style', `color: ${status.color};`);
    statusLabel.append(status.name);

    const statusDiv = document.createElement('div');
    statusDiv.append(statusBox);
    statusDiv.append(' ');
    statusDiv.append(statusLabel);

    this.elStatus.append(statusDiv);

    status.nodes.forEach((node) => {
      const marker = this.renderNode(node);
      if (marker) marker.bindTo('map', layer, 'map');
    });
  }

  renderNode(node) {
    if (!node.lat || !node.lng) {
      return false;
    }

    const marker = new google.maps.Marker({
      icon: node.icon,
      map: this.gMap,
      position: new google.maps.LatLng(node.lat, node.lng),
      title: node.name,
    });
    marker.addListener('click', () => {
      this.gInfoWindow.setContent(node.infowindow);
      this.gInfoWindow.open(this.gMap, marker);
    });
    this.gBounds.extend(marker.position);

    this.markers.push(marker);
    return marker;
  }
}

export default MapBuilder;
