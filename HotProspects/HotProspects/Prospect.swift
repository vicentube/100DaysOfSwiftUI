// Prospect.swift
// HotProspects
//
// Creado el 11/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

class Prospect: Identifiable, Codable {
  let id = UUID()
  var name = "Anonymous"
  var emailAddress = ""
  fileprivate(set) var isContacted = false
}

class Prospects: ObservableObject {
  @Published var people: [Prospect]
  
  init() {
    self.people = []
  }
  
  func toggle(_ prospect: Prospect) {
    objectWillChange.send()
    prospect.isContacted.toggle()
  }
}
