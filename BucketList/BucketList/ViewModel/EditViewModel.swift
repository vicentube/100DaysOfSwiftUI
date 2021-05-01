// EditViewModel.swift
// BucketList
//
// Creado el 1/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation
import MapKit

final class EditViewModel: ObservableObject {
  @Published var placemark: MKPointAnnotation
  @Published var loadingState = LoadingState.loading
  @Published var pages = [Page]()
  @Published var showingAlert = false
  @Published var alertMessage = ""
  
  let networkService: NetworkService
  
  init(placemark: MKPointAnnotation, networkService: NetworkService = WikipediaNetworkService()) {
    self.placemark = placemark
    self.networkService = networkService
  }
  
  func fetchNearbyPlaces() {
    networkService.fetchNearbyPlaces(latitude: placemark.coordinate.latitude, longitude: placemark.coordinate.longitude) { pages, error in
      if let pages = pages {
        self.loadingState = .loaded
        self.pages = pages
      } else if let error = error {
        self.loadingState = .failed
        self.alertMessage = error
        self.showingAlert = true
      }
    }
  }
}
