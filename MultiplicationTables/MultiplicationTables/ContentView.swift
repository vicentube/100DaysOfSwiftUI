// ContentView.swift
// MultiplicationTables
//
// Creado el 16/3/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct ContentView: View {
  @State private var game = Game()
  
  var body: some View {
    Group {
      if self.game.gameActive {
        GameView(game: $game)
      } else {
        SettingsView(game: $game)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
