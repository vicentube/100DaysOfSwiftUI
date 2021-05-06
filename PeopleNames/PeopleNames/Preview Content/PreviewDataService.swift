// PreviewDataService.swift
// PeopleNames
//
// Creado el 4/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation
import UIKit.UIImage

final class PreviewDataService: DataService {
  var error = ""
  
  let contacts = [
    Contact(id: UUID(uuidString: "90D288E5-AD7B-4F18-9E44-7F54EBD1FEE0")!,
            name: "Luke Skywalker",
            notes: "From Star Wars"),
    Contact(id: UUID(uuidString: "F35AE13E-2EFF-4EE5-A0E7-7ADDA9C7B262")!,
            name: "Indiana Jones",
            notes: "From Indiana Jones")
  ]
  
  init() { }
  
  func getAllContacts(_ completion: @escaping ([Contact]?) -> Void) {
    completion(contacts)
  }
  
  func saveContact(contact: Contact, _ completion: @escaping (Bool) -> Void) {
    
  }
  
  func getContact(index: Int) -> Contact {
    contacts[index]
  }
  
  func getImage(index: Int) -> UIImage {
    UIImage(named: "\(contacts[index].id)")!
  }
}
