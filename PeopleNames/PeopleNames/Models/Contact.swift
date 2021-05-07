// Person.swift
// PeopleNames
//
// Creado el 4/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation
import UIKit.UIImage
import MapKit

struct Contact: Identifiable, Comparable {
  var id: UUID
  var name: String
  var notes: String
  var image: UIImage?
  var location: CLLocationCoordinate2D
  
  init(id: UUID, name: String, notes: String, location: CLLocationCoordinate2D) {
    var imageTemp: UIImage?
    let url = getDocumentsDirectory().appendingPathComponent("\(id)")
    if let data = try? Data(contentsOf: url) {
      imageTemp = UIImage(data: data)
    } else {
      imageTemp = nil
    }
    self.init(id: id, name: name, notes: notes, image: imageTemp, location: location)
  }
  
  init(id: UUID, name: String, notes: String, image: UIImage?, location: CLLocationCoordinate2D) {
    self.id = id
    self.name = name
    self.notes = notes
    self.image = image
    self.location = location
  }
  
  static func < (lhs: Contact, rhs: Contact) -> Bool {
    lhs.name < rhs.name
  }
  
  static func == (lhs: Contact, rhs: Contact) -> Bool {
    lhs.id == rhs.id
  }
}
