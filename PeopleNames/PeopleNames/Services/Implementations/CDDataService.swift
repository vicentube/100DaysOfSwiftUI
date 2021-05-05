// CDDataService.swift
// PeopleNames
//
// Creado el 4/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

final class CDDataService: DataService {
  let moc = PersistenceController.shared.container.viewContext
  
  init() {
    
  }
  
  func getAllContacts(_ completion: @escaping ([Contact]?, String?) -> Void) {
    
  }
}
