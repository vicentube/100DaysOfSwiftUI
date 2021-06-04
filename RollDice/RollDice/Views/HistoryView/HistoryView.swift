// HistoryView.swift
// RollDice
//
// Creado el 24/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct HistoryView: View {
  @ObservedObject var appState = RollDiceApp.controller.appState
  private let interactor = RollDiceApp.controller.historyViewInteractor
  
  var body: some View {
    NavigationView {
      List {
        ForEach(appState.history) { round in
          Text("\(round.value)")
        }
      }
      .navigationBarTitle("History")
      .toolbar { toolbar }
    }
  }
  
  var toolbar: some ToolbarContent {
    ToolbarItem(placement: .navigationBarTrailing) {
      Button(action: interactor.clearHistory) {
        Text("Clear history")
      }
    }
  }
}

struct HistoryView_Previews: PreviewProvider {
  static var previews: some View {
    RollDiceApp.controller = RollDiceApp.preview
    return HistoryView()
  }
}

