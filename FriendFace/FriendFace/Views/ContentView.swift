// ContentView.swift
// FriendFace
//
// Creado el 15/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct ContentView: View {
  @Environment(\.managedObjectContext) var moc
  @FetchRequest(
    entity: User.entity(),
    sortDescriptors: [NSSortDescriptor(keyPath: \User.name, ascending: true)]
  ) var users: FetchedResults<User>
  
  var body: some View {
    NavigationView {
      List {
        ForEach(users) { user in
          NavigationLink(destination: DetailView(user: user)) {
            UserRow(user: user)
          }
        }
      }
      .navigationBarTitle("Users")
    }
    .onAppear(perform: {
      if users.isEmpty {
        PersistenceController.shared.loadData()
      }
    })
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
