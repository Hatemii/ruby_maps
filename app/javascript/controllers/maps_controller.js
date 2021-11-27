import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [
    "field",
    "map",
    "latitude",
    "longitude",
    "postal_code",
    "route",
    "street_number",
    "neighborhood",
    "locality",
    "country",
    "postal_code"
  ]
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

  places() {
    const autocomplete = new google.maps.places.Autocomplete(this.fieldTarget)
    autocomplete.bindTo('bounds', this.map)
    autocomplete.setFields(['place_id', 'address_components', 'geometry', 'icon', 'name'])

    return autocomplete
  }

  autocomplete_handle() {
    var autocomplete = this.places()
    
    autocomplete.addListener('place_changed', () => {
      const place = autocomplete.getPlace()

      const marker = new google.maps.Marker({
        map: this.map,
        anchorPoint: new google.maps.Point(0, -29),
        animation: google.maps.Animation.DROP,
        title: place.name,
        icon: place.icon
      });

      var addressComponents = place.address_components
      for (var i = 0; i < addressComponents.length; i++){
        switch(addressComponents[i].types[0]) {
          case "route":
            this.routeTarget.value = addressComponents[i].long_name
            break;
          case "street_number":
            this.street_numberTarget.value = addressComponents[i].long_name
            break;
          case "neighborhood":
            this.neighborhoodTarget.value = addressComponents[i].long_name
            break;
          case "locality":
            this.localityTarget.value = addressComponents[i].long_name
            break;
          case "country":
            this.countryTarget.value = addressComponents[i].long_name
            break;
          case "postal_code":
            this.postal_codeTarget.value = addressComponents[i].long_name
            break;
          default:
            null
        }
      }

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