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
  @Published private(set) var people: [Prospect]
  
  static let saveKey = "SavedData"
  
  init() {
    if let data = UserDefaults.standard.data(forKey: Self.saveKey) {
      if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
        self.people = decoded
        return
      }
    }
    
    self.people = []
  }
  
  private func save() {
    if let encoded = try? JSONEncoder().encode(people) {
      UserDefaults.standard.set(encoded, forKey: Self.saveKey)
    }
  }
  
  func add(_ prospect: Prospect) {
    people.append(prospect)
    save()
  }
  
  func toggle(_ prospect: Prospect) {
    objectWillChange.send()
    prospect.isContacted.toggle()
    save()
  }
}
