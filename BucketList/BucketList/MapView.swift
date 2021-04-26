// MapView.swift
// BucketList
//
// Creado el 26/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
  @Binding var centerCoordinate: CLLocationCoordinate2D
  var annotations: [MKPointAnnotation]
  
  func makeUIView(context: Context) -> MKMapView {
    let mapView = MKMapView()
    mapView.delegate = context.coordinator
    return mapView
  }
  
  func updateUIView(_ view: MKMapView, context: Context) {
    if annotations.count != view.annotations.count {
      view.removeAnnotations(view.annotations)
      view.addAnnotations(annotations)
    }
  }
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  class Coordinator: NSObject, MKMapViewDelegate {
    var parent: MapView
    
    init(_ parent: MapView) {
      self.parent = parent
    }
    
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
      parent.centerCoordinate = mapView.centerCoordinate
    }
  }
}
