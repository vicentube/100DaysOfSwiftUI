// CDDataService.swift
// PeopleNames
//
// Creado el 4/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation
import CoreData

final class CDDataService: DataService {
  var error = ""
  
  let moc = PersistenceController.shared.container.viewContext
  
  init() { }
  
  func getAllContacts(_ completion: @escaping ([Contact]?) -> Void) {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDContact")
    var contacts = [Contact]()
    do {
      let fetchedContacts = try moc.fetch(fetchRequest) as! [CDContact]
      contacts = fetchedContacts.map { $0.convertToDto() }
    } catch {
      self.error = "Failed to fetch contacts: \(error)"
      completion(nil)
    }
    completion(contacts)
  }
  
  func saveContact(contact: Contact, _ completion: @escaping (Bool) -> Void) {
    let newContact = CDContact(context: moc)
    newContact.fillFromDto(contact)
    
    do {
      try moc.save()
    } catch {
      self.error = "Contact could not be saved"
      completion(false)
      return
    }
    completion(true)
  }
}
