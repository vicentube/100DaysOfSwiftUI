// EditView.swift
// BucketList
//
// Creado el 27/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI
import MapKit

struct EditView: View {
  @Environment(\.presentationMode) var presentationMode
  @ObservedObject var placemark: MKPointAnnotation
  
  @State private var loadingState = LoadingState.loading
  @State private var pages = [Page]()
  
  var body: some View {
    NavigationView {
      Form {
        Section {
          TextField("Place name", text: $placemark.wrappedTitle)
          TextField("Description", text: $placemark.wrappedSubtitle)
        }
        
        Section(header: Text("Nearby...")) {
          if loadingState == .loaded {
            List(pages, id: \.pageid) { page in
              Text(page.title)
                .font(.headline)
                + Text(": ") +
                Text(page.description)
                .italic()
            }
          } else if loadingState == .loading {
            Text("Loading...")
          } else {
            Text("Please try again later.")
          }
        }
      }
      .navigationBarTitle("Edit place")
      .navigationBarItems(trailing: Button("Done") {
        presentationMode.wrappedValue.dismiss()
      })
      .onAppear(perform: fetchNearbyPlaces)
    }
  }
  
  enum LoadingState {
    case loading, loaded, failed
  }
  
  func fetchNearbyPlaces() {
    let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(placemark.coordinate.latitude)%7C\(placemark.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
    
    guard let url = URL(string: urlString) else {
      print("Bad URL: \(urlString)")
      return
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
      if let data = data {
        // we got some data back!
        let decoder = JSONDecoder()
        
        if let items = try? decoder.decode(Result.self, from: data) {
          // success – convert the array values to our pages array
          pages = Array(items.query.pages.values).sorted()
          loadingState = .loaded
          return
        }
      }
      
      // if we're still here it means the request failed somehow
      self.loadingState = .failed
    }.resume()
  }
}
