// NetworkService.swift
// BucketList
//
// Creado el 30/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation
import MapKit

protocol NetworkService {
  func fetchNearbyPlaces(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping ([Page]?, String?) -> Void)
}

final class WikipediaNetworkService: NetworkService {
  func fetchNearbyPlaces(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping ([Page]?, String?) -> Void) {
    let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(latitude)%7C\(longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
    
    guard let url = URL(string: urlString) else {
      completion(nil, "Bad URL: \(urlString)")
      return
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
      if let data = data {
        // we got some data back!
        let decoder = JSONDecoder()
        
        if let items = try? decoder.decode(Result.self, from: data) {
          // success – convert the array values to our pages array
          DispatchQueue.main.async {
            completion(Array(items.query.pages.values).sorted(), nil)
          }
        } else {
          completion([Page](), nil)
        }
      } else {
        // if we're still here it means the request failed somehow
        DispatchQueue.main.async {
          completion(nil, error?.localizedDescription ?? "Unknown error")
        }
      }
    }.resume()
  }
}
