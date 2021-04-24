// Test1View.swift
// BucketList
//
// Creado el 24/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct Test1View: View {
  let users = [
    User(firstName: "Arnold", lastName: "Rimmer"),
    User(firstName: "Kristine", lastName: "Kochanski"),
    User(firstName: "David", lastName: "Lister")
  ].sorted()
  
  var body: some View {
    List(users) { user in
      Text("\(user.lastName), \(user.firstName)")
    }
  }
}

struct Test1View_Previews: PreviewProvider {
  static var previews: some View {
    Test1View()
  }
}

struct User: Identifiable, Comparable {
  let id = UUID()
  let firstName: String
  let lastName: String
  
  static func < (lhs: User, rhs: User) -> Bool {
    lhs.lastName < rhs.lastName
  }
}
