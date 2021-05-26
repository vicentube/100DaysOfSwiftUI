// Day96_2.swift
// SnowSeeker
//
// Creado el 26/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct Day96_2: View {
  @State private var selectedUser: User? = nil
  
  var body: some View {
    Text("Hello, World!")
      .onTapGesture {
        selectedUser = User()
      }
      .alert(item: $selectedUser) { user in
        Alert(title: Text(user.id))
      }
  }
}

struct Day96_2_Previews: PreviewProvider {
  static var previews: some View {
    Day96_2()
  }
}

struct User: Identifiable {
  var id = "Taylor Swift"
}
