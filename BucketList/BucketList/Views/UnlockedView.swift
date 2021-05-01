// UnlockedView.swift
// BucketList
//
// Creado el 29/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct UnlockedView: View {
  @StateObject private var vm = UnlockedViewModel()
  
  var body: some View {
    ZStack {
      MapView(
        centerCoordinate: $vm.centerCoordinate,
        selectedPlace: $vm.selectedPlace,
        showingPlaceDetails: $vm.showingPlaceDetails,
        annotations: vm.locations)
        .edgesIgnoringSafeArea(.all)
        .alert(isPresented: $vm.showingPlaceDetails) {
          Alert(
            title: Text(vm.selectedPlace?.title ?? "Unknown"),
            message: Text(vm.selectedPlace?.subtitle ?? "Missing place information"),
            primaryButton: .default(Text("OK")),
            secondaryButton: .default(Text("Edit")) {
              vm.showingEditScreen = true
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
            newLocation.coordinate = vm.centerCoordinate
            vm.locations.append(newLocation)
            vm.selectedPlace = newLocation
            vm.showingEditScreen = true
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
    .sheet(isPresented: $vm.showingEditScreen, onDismiss: vm.saveData) {
      if let selectedPlace = vm.selectedPlace {
        EditView(placemark: selectedPlace)
      }
    }
    .onAppear(perform: vm.loadData)
  }
}

struct UnlockedView_Previews: PreviewProvider {
  static var previews: some View {
    UnlockedView()
  }
}

