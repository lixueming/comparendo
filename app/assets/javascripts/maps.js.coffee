# create namespace
ga = window.ga || {}
ga.maps = ga.maps || {}
ga.maps.hooks = ga.maps.hooks || {}
window.ga = ga

ga.maps.hooks.companyMap = ()->
  if $('#company_add3_form, #company_edit_form').length > 0
    center = new google.maps.LatLng(46.83765,8.322144)
    mapOptions = {
      zoom: 7,
      center: center,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }
    map = new google.maps.Map(document.getElementById('map_canvas'), mapOptions)

    lat = parseFloat($('#company_latitude').val())
    lng = parseFloat($('#company_longitude').val())
    if isNaN(lat) or isNaN(lng)
      latLng = center
    else
      latLng = new google.maps.LatLng(lat, lng)

    marker = new google.maps.Marker({
      position: latLng,
      title: 'Point A',
      map: map,
      draggable: true
    });

    google.maps.event.addListener(marker, 'drag', ()->
      latLng = marker.getPosition()
      $('#company_latitude').val(latLng.lat())
      $('#company_longitude').val(latLng.lng())
    )

    $('#company_latitude').val(latLng.lat())
    $('#company_longitude').val(latLng.lng())

ga.maps.hooks.showMap = ()->
  $('.map_canvas.readonly').each ()->
    lat = parseFloat( $(this).attr('latitude') )
    lng = parseFloat( $(this).attr('longitude') )
    zoom = parseInt( $(this).attr('zoom') ) || 10

    center = new google.maps.LatLng(lat, lng)
    mapOptions = {
      zoom: zoom,
      center: center,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }
    map = new google.maps.Map($(this)[0], mapOptions)

    marker = new google.maps.Marker({
      position: center,
      map: map
    })

ga.maps.hooks.showMapMulti = ()->
  $('.map_canvas.readonly_multiple').each ()->
    data = $(this).attr('data')
    companiesData = JSON.parse(data)
    zoom = parseInt( $(this).attr('zoom') ) || 9

    infoWindowLatOffset = 1
    lat = parseFloat(companiesData[0].latitude)
    lng = parseFloat(companiesData[0] .longitude)
    firstCompanyCoordinates = new google.maps.LatLng(lat+infoWindowLatOffset, lng)

    # calculate center
    center_x = 0
    center_y = 0
    min_x = 60
    max_x = 0

    for company in companiesData
      center_x += parseFloat(company.latitude)
      center_y += parseFloat(company.longitude)
      min_x = company.latitude if company.latitude < min_x
      max_x = company.latitude if company.latitude > max_x
    center_x = lat+infoWindowLatOffset
    center_y = center_y / companiesData.length
    center = new google.maps.LatLng(center_x, center_y)

    zoom = 6 if max_x - min_x > 1
    zoom = 10 if max_x - min_x < 0.04

    mapOptions = {
      zoom: zoom,
      center: center,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }
    map = new google.maps.Map(this, mapOptions)

    infowindow = new google.maps.InfoWindow()
    createMarker = (company)->
      marker = new google.maps.Marker({
        position: new google.maps.LatLng(company.latitude, company.longitude),
        map: map,
        title: company.name
      })

      google.maps.event.addListener(marker, 'click', ()->
        city_name = if !company.city_name then '(city not set)' else  company.city_name
        content = '<a href="' + company.url + '">' + company.name + '</a><br />' + city_name
        infowindow.setContent(content)
        infowindow.open(map,this)
      )
      return marker

    firstCompanyMarker = createMarker(companiesData[0])
    google.maps.event.trigger(firstCompanyMarker, 'click')
    createMarker(companiesData[i]) for i in [1..companiesData.length-1] by 1


$(document).ready ()->
  ga.maps.hooks.companyMap()
  ga.maps.hooks.showMap()
  