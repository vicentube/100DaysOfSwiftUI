// Test1View.swift
// HotProspects
//
// Creado el 8/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct Test1View: View {
  let user = User()
  
  var body: some View {
    VStack {
      EditView()
      DisplayView()
    }
    .environmentObject(user)
  }
}

struct Test1View_Previews: PreviewProvider {
  static var previews: some View {
    Test1View()
  }
}

class User: ObservableObject {
  @Published var name = "Taylor Swift"
}

struct EditView: View {
  @EnvironmentObject var user: User
  
  var body: some View {
    TextField("Name", text: $user.name)
  }
}

struct DisplayView: View {
  @EnvironmentObject var user: User
  
  var body: some View {
    Text(user.name)
  }
}
