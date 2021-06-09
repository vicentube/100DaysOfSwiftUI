// ContentView.swift
// RollDice
//
// Creado el 24/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct ContentView: View {
  @StateObject private var vm = ViewModel()
  
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
    .alert(item: $vm.error, content: errorView)
  }
  
  func errorView(_ error: ErrorMsg) -> Alert {
    Alert(
      title: Text("Error"),
      message: Text(error.message),
      dismissButton: .default(Text("OK"))
    )
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    AppModel.shared = .preview
    return ContentView()
  }
}
