// UnlockedView.swift
// BucketList
//
// Creado el 29/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI
import MapKit

struct UnlockedView: View {
  @ObservedObject var model: Model
  @State private var centerCoordinate = CLLocationCoordinate2D()
  @State private var selectedPlace: MKPointAnnotation?
  @State private var showingPlaceDetails = false
  @State private var showingEditScreen = false
  
  var body: some View {
    ZStack {
      MapView(
        centerCoordinate: $centerCoordinate,
        selectedPlace: $selectedPlace,
        showingPlaceDetails: $showingPlaceDetails,
        annotations: model.locations)
        .edgesIgnoringSafeArea(.all)
        .alert(isPresented: $showingPlaceDetails) {
          Alert(
            title: Text(selectedPlace?.title ?? "Unknown"),
            message: Text(selectedPlace?.subtitle ?? "Missing place information"),
            primaryButton: .default(Text("OK")),
            secondaryButton: .default(Text("Edit")) {
              showingEditScreen = true
            })
        }
      Circle()
        .fill(Color.blue)
        .opacity(0.3)
        .frame(width: 32, height: 32)
      VStack {
        Spacer()
        HStack {
          Spacer()
          Button(action: {
            let newLocation = CodableMKPointAnnotation()
            newLocation.title = "Example location"
            newLocation.subtitle = "n/a"
            newLocation.coordinate = centerCoordinate
            model.locations.append(newLocation)
            selectedPlace = newLocation
            showingEditScreen = true
          }) {
            Image(systemName: "plus")
              .padding()
              .background(Color.black.opacity(0.75))
              .foregroundColor(.white)
              .font(.title)
              .clipShape(Circle())
              .padding(.trailing)
          }
        }
      }
    }
    .sheet(isPresented: $showingEditScreen, onDismiss: model.saveData) {
      if let selectedPlace = selectedPlace {
        EditView(model: model, placemark: selectedPlace)
      }
    }
    .onAppear(perform: model.loadData)
  }
}

struct UnlockedView_Previews: PreviewProvider {
  static var previews: some View {
    UnlockedView(model: Model())
  }
}
