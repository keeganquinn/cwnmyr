import { MapBuilder } from 'components/map_builder'
import createGoogleMapsMock from 'jest-google-maps-mock'

const stubApis = function () {
  window.google = { maps: createGoogleMapsMock() }
  window.google.maps.InfoWindow = jest.fn().mockImplementation(
    function () {
      this.open = jest.fn()
      this.setContent = jest.fn()
    }
  )
  window.google.maps.LatLngBounds = jest.fn().mockImplementation(
    function () {
      this.extend = jest.fn()
    }
  )
  window.google.maps.Map = jest.fn().mockImplementation(
    function (mapDiv, opts) {
      this.mapDiv = mapDiv
      this.opts = opts
      this.controls = {}
      this.controls[window.google.maps.ControlPosition.TOP_RIGHT] = []
      this.setTilt = function () {}
      this.mapTypes = {
        set: function () {}
      }
      this.overlayMapTypes = {
        insertAt: function () {},
        removeAt: function () {}
      }
      this.fitBounds = function () {}
      this.panToBounds = function () {}
    })
  window.scrollTo = jest.fn()

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
    expect(mapBuilder.elMap).toBeFalsy()
  })

  describe('attached', () => {
    beforeEach(() => {
      document.body.innerHTML = page
      mapBuilder.prepare()
      mapBuilder.initMap()
    })

    it('has element reference', () => {
      expect(mapBuilder.elMap).toBeTruthy()
    })

    describe('with node data', () => {
      beforeEach(() => {
        stubApis()
        mapBuilder.handleResponse(null, {
          node: {
            lat: 1,
            lng: 1,
            icon: 'icon',
            name: 'Node',
            infowindow: 'Node Information'
          }
        })
      })

      it('creates a status display', () => {
        expect(mapBuilder.elStatus).toBeTruthy()
      })

      it('creates a marker that can be clicked', () => {
        const marker = mapBuilder.markers[0]
        marker.listeners['click'][0]()
        expect(mapBuilder.gInfoWindow.setContent.mock.calls.length).toBe(1)
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
        mapBuilder.handleResponse(null, {
          statuses: [{
            default_display: true,
            color: 'blue',
            name: 'Status',
            nodes: [{
              lat: 1,
              lng: 1,
              icon: 'icon',
              name: 'Node',
              infowindow: 'Node Information'
            }, {
              icon: 'icon',
              name: 'Uncoded Node',
              infowindow: 'More Node Information'
            }]
          }, {
            default_display: false,
            color: 'green',
            name: 'Other Status',
            nodes: [{
              lat: 2,
              lng: 2,
              icon: 'icon',
              name: 'Other Node',
              infowindow: 'Other Node Information'
            }, {
              icon: 'icon',
              name: 'Other Uncoded Node',
              infowindow: 'Yet More Node Information'
            }]
          }]
        })
      })

      it('creates a status display', () => {
        expect(mapBuilder.elStatus).toBeTruthy()
      })

      it('show button can be clicked', () => {
        mapBuilder.elBtnShow.click()
        const boxes = mapBuilder.elStatus.querySelectorAll(
          'input[type="checkbox"]')
        for (const box of boxes) {
          expect(box.checked).toBeTruthy()
        }
      })

      it('hide button can be clicked', () => {
        mapBuilder.elBtnHide.click()
        const boxes = mapBuilder.elStatus.querySelectorAll(
          'input[type="checkbox"]')
        for (const box of boxes) {
          expect(box.checked).toBeFalsy()
        }
      })
    })

    describe('with zone data', () => {
      beforeEach(() => {
        stubApis()
        mapBuilder.handleResponse(null, {
          zone: {
            statuses: [{
              default_display: true,
              color: 'blue',
              name: 'Status',
              nodes: [{
                lat: 1,
                lng: 1,
                icon: 'icon',
                name: 'Node',
                infowindow: 'Node Information'
              }]
            }]
          }
        })
      })

      it('creates a status display', () => {
        expect(mapBuilder.elStatus).toBeTruthy()
      })
    })
  })
})
