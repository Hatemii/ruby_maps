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
      center: new google.maps.LatLng(this.data.get("latitude") || 39.5, this.data.get("longitude") || -98.35),
      zoom: 8
    })
    
    this.autocomplete = new google.maps.places.Autocomplete(this.fieldTarget)
    this.autocomplete.bindTo('bounds', this.map)
    this.autocomplete.setFields(['address_components', 'geometry', 'icon', 'name'])
    this.atocomplete.addListener('place_changed', this.placeChanged.bind(this))
    
    this.marker = new google.maps.Marker({
      position: this.map,
      map: this.map,
      draggable: true,
      anchorPoint: new google.maps.Point(0, -29),
      animation: google.maps.Animation.DROP
    })

  }


  placeChanged() {
    let place = this.autocomplete.getPlace()

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

    this.marker.setPosition(place.geometry.location)
    this.marker.setVisible(true)

    this.latitudeTarget.value = place.geometry.location.lat()
    this.longitudeTarget.value = place.geometry.location.lng()
  }

  keydown(event) {
    if (event.key == "Enter") {
      event.preventDefault()
    }
  }

  // preventSubmit(e) {
  //   if (e.key == "Enter") {
  //     e.preventDefault()
  //   }
  // }
}