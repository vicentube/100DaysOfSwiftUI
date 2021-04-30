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
  @ObservedObject var model: Model
  @ObservedObject var placemark: MKPointAnnotation
  
  @State private var loadingState = LoadingState.loading
  @State private var pages = [Page]()
  @State private var showingAlert = false
  @State private var alertMessage = Text("")
  
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
      .alert(isPresented: $showingAlert) {
        Alert(title: Text("Error"), message: alertMessage, dismissButton: .default(Text("OK")))
      }
      .onAppear(perform: fetchNearbyPlaces)
    }
  }
  
  func fetchNearbyPlaces() {
    model.getNearbyPlaces(placemark: placemark) { pages, error in
      if let pages = pages {
        loadingState = .loaded
        self.pages = pages
      } else if let error = error {
        loadingState = .failed
        alertMessage = Text(error)
        showingAlert = true
      }
    }
  }
}
