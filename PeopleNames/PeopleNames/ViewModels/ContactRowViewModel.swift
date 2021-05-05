// ContactRowViewModel.swift
// PeopleNames
//
// Creado el 4/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

final class ContactRowViewModel: ObservableObject {
  let contact: Contact
  
  init(contact: Contact) {
    self.contact = contact
  }
  
  
  
}
