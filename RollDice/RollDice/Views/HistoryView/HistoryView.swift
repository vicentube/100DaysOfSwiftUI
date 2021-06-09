// HistoryView.swift
// RollDice
//
// Creado el 24/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct HistoryView: View {
  @StateObject private var vm = ViewModel()
  
  var body: some View {
    NavigationView {
      List {
        ForEach(vm.history) { round in
          Text("\(round.value)")
        }
      }
      .navigationBarTitle("History")
      .toolbar { toolbar }
    }
  }
  
  var toolbar: some ToolbarContent {
    ToolbarItem(placement: .navigationBarTrailing) {
      Button(action: vm.onClearHistoryTap) {
        Text("Clear history")
      }
    }
  }
}

struct HistoryView_Previews: PreviewProvider {
  static var previews: some View {
    AppModel.shared = .preview
    return HistoryView()
  }
}

