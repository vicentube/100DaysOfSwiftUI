// ContentView.swift
// FriendFace
//
// Creado el 15/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var store: DataStore
  
  var body: some View {
    NavigationView {
      List {
        ForEach(store.users) { user in
          NavigationLink(destination: DetailView(user: user)) {
            UserRow(user: user)
          }
        }
      }
      .navigationBarTitle("Users")
    }
    .onAppear(perform: store.loadData)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
