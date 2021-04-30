// Model.swift
// BucketList
//
// Creado el 30/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation
import MapKit

final class Model: ObservableObject {
  @Published var isUnlocked = false
  @Published var locations = [CodableMKPointAnnotation]()
  
  var errorDescription = ""
  
  func authenticate(handler: @escaping (String?) -> Void) {
    AuthenticationService.authenticate(handler: handler)
  }
  
  private func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }
  
  func loadData() {
    let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
    
    do {
      print(filename.absoluteString)
      let data = try Data(contentsOf: filename)
      locations = try JSONDecoder().decode([CodableMKPointAnnotation].self, from: data)
    } catch {
      print("Unable to load saved data.")
    }
  }
  
  func saveData() {
    do {
      let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
      let data = try JSONEncoder().encode(locations)
      try data.write(to: filename, options: [.atomicWrite])
      // try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
    } catch {
      print("Unable to save data.")
    }
  }
  
  func getNearbyPlaces(placemark: MKPointAnnotation, handler: @escaping ([Page]?, String?) -> Void) {
    NetworkService.fetchNearbyPlaces(latitude: placemark.coordinate.latitude, longitude: placemark.coordinate.longitude, handler: handler)
  }
}
