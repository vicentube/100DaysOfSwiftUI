// ContentView.swift
// FriendFace
//
// Creado el 15/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct ContentView: View {
  @ObservedObject var store = DataStore()
  
  var body: some View {
    VStack {
      List {
        ForEach(store.users) { user in
          UserRow(user: user)
        }
      }
    }
    .onAppear(perform: store.loadData)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
