import { MapBuilder } from 'components/map_builder'

import ahoy from 'ahoy.js'

var Turbolinks = require('turbolinks')
Turbolinks.start()

require('styles/page.css.scss')
require('bootstrap/dist/js/bootstrap.js')

const Rails = require('rails-ujs')
Rails.start()

var mb = new MapBuilder()

document.addEventListener('turbolinks:load', function (event) {
  ahoy.trackView()
  mb.initMap()

  let elSearch = document.getElementById('search')
  let elQuery = document.getElementById('query')
  if (!elSearch || !elQuery) return

  elSearch.addEventListener('submit', function (event) {
    let query = encodeURIComponent(elQuery.value)
    Turbolinks.visit(`/search?query=${query}`)

    event.preventDefault()
    return false
  })
})
