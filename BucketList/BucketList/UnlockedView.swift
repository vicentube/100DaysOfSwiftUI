// UnlockedView.swift
// BucketList
//
// Creado el 29/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI
import MapKit

struct UnlockedView: View {
  @State private var centerCoordinate = CLLocationCoordinate2D()
  @State private var locations = [CodableMKPointAnnotation]()
  @State private var selectedPlace: MKPointAnnotation?
  @State private var showingPlaceDetails = false
  @State private var showingEditScreen = false
  
  var body: some View {
    ZStack {
      MapView(
        centerCoordinate: $centerCoordinate,
        selectedPlace: $selectedPlace,
        showingPlaceDetails: $showingPlaceDetails,
        annotations: locations)
        .edgesIgnoringSafeArea(.all)
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
            locations.append(newLocation)
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
    .alert(isPresented: $showingPlaceDetails) {
      Alert(
        title: Text(selectedPlace?.title ?? "Unknown"),
        message: Text(selectedPlace?.subtitle ?? "Missing place information"),
        primaryButton: .default(Text("OK")),
        secondaryButton: .default(Text("Edit")) {
          showingEditScreen = true
        })
    }
    .sheet(isPresented: $showingEditScreen, onDismiss: saveData) {
      if let selectedPlace = selectedPlace {
        EditView(placemark: selectedPlace)
      }
    }
    .onAppear(perform: loadData)
  }
  
  func getDocumentsDirectory() -> URL {
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
}

struct UnlockedView_Previews: PreviewProvider {
  static var previews: some View {
    UnlockedView()
  }
}
