// DataService.swift
// PeopleNames
//
// Creado el 4/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

protocol DataService {
  var error: String { get set }
  
  func getAllContacts(_ completion: @escaping ([Contact]?) -> Void)
  func saveContact(contact: Contact, _ completion: @escaping (Bool) -> Void)
}
