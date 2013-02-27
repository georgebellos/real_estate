$('#googlemap a').on('shown', (e) ->
  google.maps.event.trigger(map, 'resize')
  Gmaps.map.adjustMapToBounds()
)
