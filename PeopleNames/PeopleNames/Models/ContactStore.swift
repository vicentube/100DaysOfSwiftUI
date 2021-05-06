// ContactStore.swift
// PeopleNames
//
// Creado el 5/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation
import UIKit.UIImage

final class ContactStore: ObservableObject {
  @Published private(set) var contacts = [Contact]()
  @Published private(set) var error = ""
  
  private var service: DataService
  
  init(_ dataService: DataService = CDDataService()) {
    self.service = dataService
    getAllContacts()
  }
  
  func getAllContacts() {
    service.getAllContacts { [weak self] result in
      if let result = result {
        self?.contacts = result.sorted()
      } else {
        self?.error = self?.service.error ?? "Failed to load contacts"
      }
    }
  }
  
  func saveContact(contact: Contact) {
    guard let image = contact.image else { return }
    if let jpegData = image.jpegData(compressionQuality: 0.8) {
      let url = getDocumentsDirectory().appendingPathComponent("\(contact.id)")
      do {
        try jpegData.write(to: url, options: [.atomicWrite, .completeFileProtection])
      } catch {
        self.error = "Image could not be saved"
        return
      }
    }
    service.saveContact(contact: contact) { [weak self] success in
      if success {
        self?.getAllContacts()
      } else {
        self?.error = self?.service.error ?? "Failed to save contact"
      }
    }
  }
}
