// Prospect.swift
// HotProspects
//
// Creado el 11/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

class Prospect: Identifiable, Codable {
  var id = UUID()
  var name = "Anonymous"
  var emailAddress = ""
  fileprivate(set) var isContacted = false
  fileprivate(set) var created = Date()
}

class Prospects: ObservableObject {
  @Published private(set) var people: [Prospect]
  
  static let saveKey = "SavedData"
  static let dataFile = "prospects"
  
  init() {
    let filename = FileManager.default.getDocumentsDirectory().appendingPathComponent(Self.dataFile)
    
    do {
      print(filename.absoluteString)
      let data = try Data(contentsOf: filename)
      people = try JSONDecoder().decode([Prospect].self, from: data)
    } catch {
      print("Unable to load saved data.")
      people = []
    }
  }
  
  func add(_ prospect: Prospect) {
    people.append(prospect)
    saveData()
  }
  
  func toggle(_ prospect: Prospect) {
    objectWillChange.send()
    prospect.isContacted.toggle()
    saveData()
  }
  
  func saveData() {
    do {
      let filename = FileManager.default.getDocumentsDirectory().appendingPathComponent(Self.dataFile)
      let data = try JSONEncoder().encode(people)
      try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
    } catch {
      print("Unable to save data.")
    }
  }
  
  func sort(by field: SortField) {
    switch field {
    case .name:
      people.sort(by: { $0.name < $1.name })
    case .mostRecent:
      people.sort(by: { $0.created > $1.created })
    }
  }
}

extension FileManager {
  func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }
}

enum SortField {
  case name, mostRecent
}
