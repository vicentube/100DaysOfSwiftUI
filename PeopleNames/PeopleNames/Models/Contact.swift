// Person.swift
// PeopleNames
//
// Creado el 4/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation
import UIKit.UIImage

struct Contact: Identifiable, Comparable {
  var id: UUID
  var name: String
  var notes: String
  var image: UIImage?
  
  init(id: UUID, name: String, notes: String) {
    self.id = id
    self.name = name
    self.notes = notes
    
    let url = getDocumentsDirectory().appendingPathComponent("\(id)")
    if let data = try? Data(contentsOf: url) {
      self.image = UIImage(data: data)
    } else {
      self.image = nil
    }
  }
  
  init(id: UUID, name: String, notes: String, image: UIImage?) {
    self.id = id
    self.name = name
    self.notes = notes
    self.image = image
  }
  
  static func < (lhs: Contact, rhs: Contact) -> Bool {
    lhs.name < rhs.name
  }
}
