// Test4View.swift
// HotProspects
//
// Creado el 9/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct Test4View: View {
  @ObservedObject var updater = DelayedUpdater()
  
  var body: some View {
    Text("Value is: \(updater.value)")
  }
}

struct Test4View_Previews: PreviewProvider {
  static var previews: some View {
    Test4View()
  }
}

class DelayedUpdater: ObservableObject {
  var value = 0 {
    willSet {
      objectWillChange.send()
    }
  }
  
  init() {
    for i in 1...10 {
      DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
        self.value += 1
      }
    }
  }
}
