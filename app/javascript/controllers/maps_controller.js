import { Controller} from "stimulus"

export default class extends Controller {
  static targets = ["field", "map", "latitude", "longitude"]

  connect() {
    if (typeof (google) != "undefined") {
      this.initMap()
    }
  }

  initMap() {
    this.map = new google.maps.Map(this.mapTarget, {
      center: new google.maps.LatLng(
        // this.latitudeTarget.value,
        // this.longitudeTarget.value
        39.5,
        98.35
      ),
      zoom: 8
    })

    this.marker = new google.maps.Marker({
      position: { lat: 39.5, lng: 98.35 },
      map: this.map,
      title: "City Name",
      draggable: true,
      animation: google.maps.Animation.DROP
    })

    this.autocomplete = new google.maps.places.Autocomplete(this.fieldTarget)
    this.autocomplete.bindTo('bounds', this.map)
    this.autocomplete.setFields(['address_components', 'geometry', 'icon', 'name'])
    this.autocomplete.addListener('place_changed', this.placeChanged.bind(this))
  }


  placeChanged() {
    let place = this.autocomplete().getPlace()

    if (!place.geometry) {
      window.alert(`No details available for input: ${place.name}`);
      return;
    }

    if (place.geometry.viewport) {
      this.map.fitBounds(place.geometry.viewport)
     
    } else {
      this.map.setCenter(place.geometry.location)
      this.map.setZoom(8)
    }

    this.marker.setPosition(place.geometry.location)
    this.marker.setVisible(true)

    this.latitudeTarget.value = place.geometry.location.lat()
    this.longitudeTarget.value = place.geometry.location.lng()
  }

  // preventSubmit(e) {
  //   if (e.key == "Enter") { e.preventDefault() }
  // }

}