// User.swift
// FriendFace
//
// Creado el 15/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

struct User: Codable {
  var id: UUID
  var isActive: Bool
  var name: String
  var age: Int
  var company: String
  var email: String
  var address: String
  var about: String
  var registered: Date
  var tags: [String]
  var friends: [Friend]
}
