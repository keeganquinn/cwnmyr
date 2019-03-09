var Turbolinks = require('turbolinks')
Turbolinks.start()

require('styles/page.css.scss')
require('bootstrap/dist/js/bootstrap.js')

const Rails = require('rails-ujs')
Rails.start()

const MapBuilder = require('components/map_builder')
var mb = new MapBuilder()
document.addEventListener('turbolinks:load', function (event) {
  mb.initMap()
})
