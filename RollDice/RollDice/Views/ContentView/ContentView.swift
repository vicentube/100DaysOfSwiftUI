// ContentView.swift
// RollDice
//
// Creado el 24/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct ContentView: View {
  private let controller: AppControllerProtocol
  private var interactor: ContentView.Interactor { controller.contentViewInteractor }
  @ObservedObject var appState: AppState
  
  
  init(_ controller: AppControllerProtocol) {
    self.controller = controller
    self.appState = controller.appState
  }
  
  var body: some View {
    TabView {
      RollView(controller)
        .tabItem {
          Image(systemName: "circle.fill.square.fill")
          Text("Roll")
        }
      
      HistoryView(controller)
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
  static var previews: some View {
    ContentView(PreviewAppController())
  }
}
