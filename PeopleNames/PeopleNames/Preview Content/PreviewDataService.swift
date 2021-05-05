// PreviewDataService.swift
// PeopleNames
//
// Creado el 4/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

final class PreviewDataService: DataService {
  
  init() {
    
  }
  
  func getAllContacts(_ completion: @escaping ([Contact]?, String?) -> Void) {
    let contacts = [
      Contact(id: UUID(uuidString: "90D288E5-AD7B-4F18-9E44-7F54EBD1FEE0")!,
              name: "Luke Skywalker",
              notes: "From Star Wars"),
      Contact(id: UUID(uuidString: "F35AE13E-2EFF-4EE5-A0E7-7ADDA9C7B262")!,
              name: "Indiana Jones",
              notes: "From Indiana Jones")
    ]
    completion(contacts, nil)
  }
  
  static func getContact(index: Int) -> Contact {
    var contact: Contact!
    PreviewDataService().getAllContacts { result, _ in
      contact = result![index]
    }
    return contact
  }
}
