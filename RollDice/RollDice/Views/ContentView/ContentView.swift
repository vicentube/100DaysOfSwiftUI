// ContentView.swift
// RollDice
//
// Creado el 24/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var appState: AppState
  private let interactor = RollDiceApp.controller.contentViewInteractor
  
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
    .onAppear(perform: interactor.loadData)
  }
}

private extension ErrorMsg {
  var alert: Alert {
    Alert(
      title: Text("Error"),
      message: Text(message),
      dismissButton: .default(Text("OK"))
    )
  }
}

struct ContentView_Previews: PreviewProvider {
  static let appState = AppState()
  
  static var previews: some View {
    RollDiceApp.controller = RollDiceApp.preview
    let appState = RollDiceApp.controller.appState
    return ContentView().environmentObject(appState)
  }
}
