// ContentView.swift
// RollDice
//
// Creado el 24/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var appState: AppState
  @Environment(\.interactors) var interactors: InteractorsContainer
  
  var body: some View {
    TabView {
      RollView()
        .tabItem {
          Image(systemName: "circle.fill.square.fill")
          Text("Roll")
        }
      
      HistoryView()
        .tabItem {
          Image(systemName: "clock.fill")
          Text("History")
        }
    }
    .alert(item: $appState.errorMsg) { $0.alert }
    .onAppear {
      interactors.settings.loadSettings()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(appState: AppState())
  }
}
