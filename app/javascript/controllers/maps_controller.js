import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["field", "map", "latitude", "longitude"]

  connect() {
    if (typeof (google) != "undefined") {
      this.initMap()
    }
  }

  initMap() {
    this.map = new google.maps.Map(this.mapTarget, {
      center: new google.maps.LatLng(this.data.get("latitude") || 1.290270, this.data.get("longitude") || 103.851959),
      zoom: 12,
      minZoom: 8
    })

    this.autocomplete_handle()
  }

  autocomplete_handle() {
    const autocomplete = new google.maps.places.Autocomplete(this.fieldTarget)

    autocomplete.bindTo('bounds', this.map)
    autocomplete.setFields(['address_components', 'geometry', 'icon', 'name'])

    const marker = new google.maps.Marker({
      map: this.map,
      anchorPoint: new google.maps.Point(0, -29),
      animation: google.maps.Animation.DROP
    });

    autocomplete.addListener('place_changed', () => {
      const place = autocomplete.getPlace()
      marker.setVisible(false)

      if (!place.geometry) {
        window.alert(`No details available for input: ${place.name}`)
        return
      }

      if (place.geometry.viewport) {
        this.map.fitBounds(place.geometry.viewport)

      } else {
        this.map.setCenter(place.geometry.location)
        this.map.setZoom(8)
      }

      marker.setPosition(place.geometry.location)
      marker.setVisible(true)

      this.latitudeTarget.value = place.geometry.location.lat().toFixed(6)
      this.longitudeTarget.value = place.geometry.location.lng().toFixed(6)

      this.mouseClickHandle(this.latitudeTarget.value, this.longitudeTarget.value)
    })

  }

  mouseClickHandle(search_lat, search_lng) {
    const marker = new google.maps.Marker({
      map: this.map,
      animation: google.maps.Animation.DROP,
      visible: false
    });

    var current_base_lat_lng = new google.maps.LatLng(search_lat, search_lng)

    this.map.addListener('click', event => {
      var mouse_lat_lng = new google.maps.LatLng(event.latLng.lat(), event.latLng.lng())

      if (this.distance_calculate(current_base_lat_lng, mouse_lat_lng)) {
        this.latitudeTarget.value = this.latitudeTarget.value
        this.longitudeTarget.value = this.longitudeTarget.value

      } else {
        this.latitudeTarget.value = event.latLng.lat().toFixed(6)
        this.longitudeTarget.value = event.latLng.lng().toFixed(6)

        marker.setPosition(event.latLng)
        marker.setVisible(true)
      }
    });
  }

  distance_calculate(point_1, point_2) {
    var distance = (google.maps.geometry.spherical.computeDistanceBetween(point_1, point_2) / 1000).toFixed(1);
    const round_distance = Math.round(distance)

    if (round_distance > 10) {
      alert("Distance more than 10km from your base location is invalid!");
      return true
    }
    return false
  }
}