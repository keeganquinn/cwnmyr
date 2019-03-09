var Turbolinks = require('turbolinks')
Turbolinks.start()

require('styles/page.css.scss')
require('bootstrap/dist/js/bootstrap.js')

const MapBuilder = require('components/map_builder')
const Rails = require('rails-ujs')

var mb = new MapBuilder()
Rails.start()

document.addEventListener('turbolinks:load', function (event) {
  mb.initMap()
})
