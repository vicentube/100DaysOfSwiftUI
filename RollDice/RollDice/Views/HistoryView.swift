// HistoryView.swift
// RollDice
//
// Creado el 24/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct HistoryView<T: Model>: View {
  @ObservedObject var model: T
  
  var body: some View {
    List {
      ForEach(model.history) { item in
        Text("\(item.result)")
      }
    }
  }
}

struct HistoryView_Previews: PreviewProvider {
  static var previews: some View {
    HistoryView(model: ModelPreview())
  }
}

