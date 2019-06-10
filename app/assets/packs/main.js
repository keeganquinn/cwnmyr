import { MapBuilder } from 'components/map_builder'

import ahoy from 'ahoy.js'
import $ from 'jquery'

window.jQuery = $
window.$ = $

var Turbolinks = require('turbolinks')
Turbolinks.start()

require('styles/page.css.scss')
require('bootstrap/dist/js/bootstrap.js')
require('bootstrap-table/dist/bootstrap-table.js')

window.linkSort = function (a, b) {
  var a = $(a).text()
  var b = $(b).text()
  if (a < b) return -1
  if (a > b) return 1

  return 0
}

const Rails = require('rails-ujs')
Rails.start()

var mb = new MapBuilder()
mb.prepare()

document.addEventListener('turbolinks:load', function (event) {
  ahoy.trackView()
  mb.initMap()
  $('[data-toggle="table"]').bootstrapTable()

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
