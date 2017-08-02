require('styles/page.css.scss')

const MapBuilder = require('components/map_builder')
const Rails = require('rails-ujs')

document.addEventListener('DOMContentLoaded', function (event) {
  Rails.start()

  var mb = new MapBuilder()
  mb.initMap()
})
