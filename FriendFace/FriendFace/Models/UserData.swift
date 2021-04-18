// UserData.swift
// FriendFace
//
// Creado el 15/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

struct UserData: Codable, Identifiable {
  var id: UUID
  var isActive: Bool
  var name: String
  var age: Int16
  var company: String
  var email: String
  var address: String
  var about: String
  var registered: String
  var tags: [String]
  var friends: [FriendData]
  
  var registeredDate: Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    return formatter.date(from: registered)
  }
  
  var dateFormatted: String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    if let date = registeredDate {
      return formatter.string(from: date)
    } else {
      return "N/A"
    }
  }
}
