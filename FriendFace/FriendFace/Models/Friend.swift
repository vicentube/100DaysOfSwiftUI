// Friend.swift
// FriendFace
//
// Creado el 15/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

struct Friend: Codable, Identifiable {
  var id: UUID
  var name: String
}
