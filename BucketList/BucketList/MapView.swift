// MapView.swift
// BucketList
//
// Creado el 25/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
  func makeUIView(context: Context) -> MKMapView {
    let mapView = MKMapView()
    return mapView
  }
  
  func updateUIView(_ uiView: MKMapView, context: Context) {
    
  }
}

struct MapView_Previews: PreviewProvider {
  static var previews: some View {
    MapView()
  }
}
