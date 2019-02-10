const MapBuilder = require('./map_builder')

const stubGoogleApis = function () {
  window.google = {
    maps: {
      Animation: {},
      BicyclingLayer: function () {},
      Circle: function () {},
      ControlPosition: {},
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
      MVCObject: function () {},
      Map: function () {
        return {
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
          addListener: function () {}
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
}

const page = `<div id="map"></div>`

describe('MapBuilder', () => {
  let mapBuilder
  beforeEach(() => {
    mapBuilder = new MapBuilder()
  })

  it('can be instantiated', () => {
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
        stubGoogleApis()
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
    })
  })
})
