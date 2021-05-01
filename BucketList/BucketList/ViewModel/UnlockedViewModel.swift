// UnlockedViewModel.swift
// BucketList
//
// Creado el 1/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation
import MapKit

final class UnlockedViewModel: ObservableObject {
  @Published var centerCoordinate = CLLocationCoordinate2D()
  @Published var selectedPlace: MKPointAnnotation?
  @Published var showingPlaceDetails = false
  @Published var showingEditScreen = false
  @Published var locations = [CodableMKPointAnnotation]()
  
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
      try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
    } catch {
      print("Unable to save data.")
    }
  }
}
