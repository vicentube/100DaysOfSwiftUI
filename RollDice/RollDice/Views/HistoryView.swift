// HistoryView.swift
// RollDice
//
// Creado el 24/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct HistoryView<T: ModelProtocol>: View {
  // MARK: - ViewModel
  @ObservedObject var model: T
  
  
  // MARK: - View
  var body: some View {
    NavigationView {
      List {
        ForEach(model.history, id: \.date) { item in
          Text("\(item.result)")
        }
      }
      .navigationBarTitle("History")
      .toolbar { toolbar }
    }
  }
  
  var toolbar: some ToolbarContent {
    ToolbarItem(placement: .navigationBarTrailing) {
      Button(action: model.clearHistory) {
        Text("Clear history")
      }
    }
  }
}

// MARK: - Preview
struct HistoryView_Previews: PreviewProvider {
  static var previews: some View {
    HistoryView(model: ModelPreview())
  }
}

