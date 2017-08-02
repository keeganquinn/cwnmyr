const MapBuilder = require('./map_builder')

describe('MapBuilder', () => {
  it('can be instantiated', () => {
    var mb = new MapBuilder()
    expect(mb.mapDiv).toBe(null)
  })
})
