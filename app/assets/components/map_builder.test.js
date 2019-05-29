const MapBuilder = require('./map_builder')

const stubApis = function () {
  window.google = {
    maps: {
      Animation: {},
      BicyclingLayer: function () {},
      Circle: function () {},
      ControlPosition: {
        TOP_RIGHT: 'TOP_RIGHT'
      },
      Data: function () {},
      DirectionsRenderer: function () {},
      DirectionsService: function () {},
      DirectionsStatus: {},
      DirectionsTravelMode: {},
      DirectionsUnitSystem: {},
      DistanceMatrixElementStatus: {},
      DistanceMatrixService: function () {},
      DistanceMatrixStatus: {},
      ElevationService: function () {},
      ElevationStatus: {},
      FusionTablesLayer: function () {},
      Geocoder: function () {},
      GeocoderLocationType: {},
      GeocoderStatus: {},
      GroundOverlay: function () {},
      ImageMapType: function () {},
      InfoWindow: function () {},
      KmlLayer: function () {},
      KmlLayerStatus: {},
      LatLng: function () {},
      LatLngBounds: function () {
        return {
          extend: function () {}
        }
      },
      MVCArray: function () {},
      MVCObject: function () {
        return {
          set: function () {}
        }
      },
      Map: function () {
        return {
          controls: {
            'TOP_RIGHT': []
          },
          setTilt: function () { },
          mapTypes: {
            set: function () { }
          },
          overlayMapTypes: {
            insertAt: function () { },
            removeAt: function () { }
          },
          fitBounds: function () {},
          panToBounds: function () {}
        }
      },
      MapTypeControlStyle: {},
      MapTypeId: {
        HYBRID: '',
        ROADMAP: '',
        SATELLITE: '',
        TERRAIN: ''
      },
      MapTypeRegistry: function () {},
      Marker: function () {
        return {
          addListener: function () {},
          bindTo: function () {}
        }
      },
      MarkerImage: function () {},
      MaxZoomService: function () {
        return {
          getMaxZoomAtLatLng: function () { }
        }
      },
      MaxZoomStatus: {},
      NavigationControlStyle: {},
      OverlayView: function () { },
      Point: function () {},
      Polygon: function () {},
      Polyline: function () {},
      Rectangle: function () {},
      SaveWidget: function () {},
      ScaleControlStyle: {},
      Size: function () {},
      StreetViewCoverageLayer: function () {},
      StreetViewPanorama: function () {},
      StreetViewService: function () {},
      StreetViewStatus: {},
      StrokePosition: {},
      StyledMapType: function () {},
      SymbolPath: {},
      TrafficLayer: function () {},
      TransitLayer: function () {},
      TransitMode: {},
      TransitRoutePreference: {},
      TravelMode: {},
      UnitSystem: {},
      ZoomControlStyle: {},
      __gjsload__: function () { },
      event: {
        addListener: function () { }
      },
      places: {
        AutocompleteService: function () {
          return {
            getPlacePredictions: function () { }
          }
        }
      }
    }
  }

  navigator.geolocation = {
    getCurrentPosition: function () {}
  }
}

const page = `<div id="map"></div>`

describe('MapBuilder', () => {
  let mapBuilder
  beforeEach(() => {
    mapBuilder = new MapBuilder()
  })

  it('can be instantiated', () => {
    mapBuilder.initMap()
    expect(mapBuilder.mapDiv).toBeFalsy()
  })

  describe('attached', () => {
    beforeEach(() => {
      document.body.innerHTML = page
      mapBuilder.initMap()
    })

    it('has element reference', () => {
      expect(mapBuilder.mapDiv).toBeTruthy()
    })

    it('can handle errors', () => {
      mapBuilder.handleError({ 'responseText': 'error' })
      expect(mapBuilder.errors[0].responseText).toEqual('error')
    })

    describe('with node data', () => {
      beforeEach(() => {
        stubApis()
        mapBuilder.handleResponse({
          'node': {
            'lat': 1,
            'lng': 1,
            'icon': 'icon',
            'name': 'Node',
            'infowindow': 'Node Information'
          }
        })
      })

      it('creates a status display', () => {
        expect(mapBuilder.statusCtrl).toBeTruthy()
      })

      it('can handle position data', () => {
        mapBuilder.handlePosition({
          coords: {
            latitude: 1,
            longitude: 1
          }
        })
        expect(mapBuilder.posMarker).toBeTruthy()
      })
    })

    describe('with status data', () => {
      beforeEach(() => {
        stubApis()
        mapBuilder.handleResponse({
          'statuses': [{
            'default_display': true,
            'color': 'blue',
            'name': 'Status',
            'nodes': [{
              'lat': 1,
              'lng': 1,
              'icon': 'icon',
              'name': 'Node',
              'infowindow': 'Node Information'
            }, {
              'icon': 'icon',
              'name': 'Uncoded Node',
              'infowindow': 'More Node Information'
            }]
          }]
        })
      })

      it('creates a status display', () => {
        expect(mapBuilder.statusCtrl).toBeTruthy()
      })
    })

    describe('with zone data', () => {
      beforeEach(() => {
        stubApis()
        mapBuilder.handleResponse({
          'zone': {
            'statuses': [{
              'default_display': true,
              'color': 'blue',
              'name': 'Status',
              'nodes': [{
                'lat': 1,
                'lng': 1,
                'icon': 'icon',
                'name': 'Node',
                'infowindow': 'Node Information'
              }]
            }]
          }
        })
      })

      it('creates a status display', () => {
        expect(mapBuilder.statusCtrl).toBeTruthy()
      })
    })
  })
})
