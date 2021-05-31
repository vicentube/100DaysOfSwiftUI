// ContentView.swift
// RollDice
//
// Creado el 24/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var appState: AppState
  @EnvironmentObject var interactors: InteractorContainer
  
  var body: some View {
    TabView {
      RollView(model: model)
        .tabItem {
          Image(systemName: "circle.fill.square.fill")
          Text("Roll")
        }
      
      HistoryView(model: model)
        .tabItem {
          Image(systemName: "clock.fill")
          Text("History")
        }
    }
    .alert(item: interactors.contentView.errorMsg) { $0.alert }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
