// NetworkService.swift
// BucketList
//
// Creado el 30/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

class NetworkService {
  
  var errorDescription = ""
  var loadingState = LoadingState.loading
  var pages = [Page]()
  
  static func fetchNearbyPlaces(latitude: Double, longitude: Double, handler: @escaping ([Page]?, String?) -> Void) {
    var pages: [Page]? = nil
    var networkError: String? = nil
    let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(latitude)%7C\(longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
    
    guard let url = URL(string: urlString) else {
      networkError = "Bad URL: \(urlString)"
      handler(nil, networkError)
      return
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
      if let data = data {
        // we got some data back!
        let decoder = JSONDecoder()
        
        if let items = try? decoder.decode(Result.self, from: data) {
          // success – convert the array values to our pages array
          DispatchQueue.main.async {
            pages = Array(items.query.pages.values).sorted()
            handler(pages, nil)
            return
          }
        }
      }
      
      // if we're still here it means the request failed somehow
      DispatchQueue.main.async {
        networkError = error?.localizedDescription ?? "Unknown error"
        handler(nil, networkError)
      }
    }.resume()
  }
}
