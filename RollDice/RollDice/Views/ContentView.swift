// ContentView.swift
// RollDice
//
// Creado el 24/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct ContentView<T: Model>: View {
  @ObservedObject var model: T
  
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
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(model: ModelFile())
  }
}
