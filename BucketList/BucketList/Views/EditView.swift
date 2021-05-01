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
  @StateObject private var vm: EditViewModel
  
  init(placemark: MKPointAnnotation) {
    self._vm = StateObject(wrappedValue: EditViewModel(placemark: placemark))
  }
  
  var body: some View {
    NavigationView {
      Form {
        Section {
          TextField("Place name", text: $vm.placemark.wrappedTitle)
          TextField("Description", text: $vm.placemark.wrappedSubtitle)
        }
        
        Section(header: Text("Nearby...")) {
          if vm.loadingState == .loaded {
            List(vm.pages, id: \.pageid) { page in
              Text(page.title)
                .font(.headline)
                + Text(": ") +
                Text(page.description)
                .italic()
            }
          } else if vm.loadingState == .loading {
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
      .alert(isPresented: $vm.showingAlert) {
        Alert(title: Text("Error"), message: Text(vm.alertMessage), dismissButton: .default(Text("OK")))
      }
      .onAppear(perform: vm.fetchNearbyPlaces)
    }
  }
}
