require('styles/page.css.scss')
require('bootstrap/dist/js/bootstrap.js')

const MapBuilder = require('components/map_builder')
const Rails = require('rails-ujs')

document.addEventListener('DOMContentLoaded', function (event) {
  Rails.start()

  var mb = new MapBuilder()
  mb.initMap()
})
