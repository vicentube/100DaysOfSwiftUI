// MapTestView.swift
// BucketList
//
// Creado el 25/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI
import MapKit

struct MapTestView: UIViewRepresentable {
  class Coordinator: NSObject, MKMapViewDelegate {
    var parent: MapTestView
    
    init(_ parent: MapTestView) {
      self.parent = parent
    }
    
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
      print(mapView.centerCoordinate)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
      let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
      view.canShowCallout = true
      return view
    }
  }
  
  
  func makeUIView(context: Context) -> MKMapView {
    let mapView = MKMapView()
    mapView.delegate = context.coordinator
    
    let annotation = MKPointAnnotation()
    annotation.title = "London"
    annotation.subtitle = "Capital of England"
    annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: 0.13)
    mapView.addAnnotation(annotation)
    
    return mapView
  }
  
  func updateUIView(_ uiView: MKMapView, context: Context) {
    
  }
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
}

struct MapView_Previews: PreviewProvider {
  static var previews: some View {
    MapTestView()
  }
}
