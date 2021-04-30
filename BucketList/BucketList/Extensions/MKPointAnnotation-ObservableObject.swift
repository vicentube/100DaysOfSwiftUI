// MKPointAnnotation-ObservableObject.swift
// BucketList
//
// Creado el 27/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import MapKit

extension MKPointAnnotation: ObservableObject {
  public var wrappedTitle: String {
    get {
      self.title ?? "Unknown value"
    }
    set {
      title = newValue
    }
  }
  
  public var wrappedSubtitle: String {
    get {
      self.subtitle ?? "Unknown value"
    }
    set {
      subtitle = newValue
    }
  }
}
