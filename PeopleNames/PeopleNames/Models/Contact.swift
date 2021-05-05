// Person.swift
// PeopleNames
//
// Creado el 4/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

struct Contact: Identifiable {
  var id: UUID
  var name: String
  var notes: String
}
