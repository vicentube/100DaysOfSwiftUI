// LocationFetcher.swift
// PeopleNames
//
// Creado el 7/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import CoreLocation
import MapKit

class LocationFetcher: NSObject, CLLocationManagerDelegate, ObservableObject {
  let manager = CLLocationManager()
  
  @Published var region = MKCoordinateRegion(
    center: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0),
    span: MKCoordinateSpan(latitudeDelta: 0.12, longitudeDelta: 0.12)
  )
  
  override init() {
    super.init()
    manager.delegate = self
  }
  
  func start() {
    manager.requestWhenInUseAuthorization()
    manager.startUpdatingLocation()
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let lastLocation = locations.first?.coordinate {
      region.center = lastLocation
    }
  }
}
