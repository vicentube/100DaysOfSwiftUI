// User.swift
// FriendFace
//
// Creado el 15/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

struct User: Codable, Identifiable {
  var id: UUID
  var isActive: Bool
  var name: String
  var age: Int
  var company: String
  var email: String
  var address: String
  var about: String
  var registered: String
  var tags: [String]
  var friends: [Friend]
  
  var dateFormatted: String {
    let getFormatter = DateFormatter()
    getFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    if let date = getFormatter.date(from: registered) {
      let printFormatter = DateFormatter()
      printFormatter.dateStyle = .medium
      printFormatter.timeStyle = .short
      return printFormatter.string(from: date)
    } else {
      return "N/A"
    }
  }
  
  static var preview: User {
    User(
      id: UUID(),
      isActive: true,
      name: "John Smith",
      age: 30,
      company: "Apple",
      email: "john.smith@apple.com",
      address: "Apple Park\nCupertino, CA\nUSA",
      about: "Working at Apple",
      registered: "2014-02-02T03:55:59-00:00",
      tags: ["irure", "proident", "quis"],
      friends: [])
  }
}
