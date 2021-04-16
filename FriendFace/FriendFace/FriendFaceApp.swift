// FriendFaceApp.swift
// FriendFace
//
// Creado el 15/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

@main
struct FriendFaceApp: App {
  @StateObject var store = DataStore()
  
  var body: some Scene {
    WindowGroup {
      ContentView().environmentObject(store)
    }
  }
}
