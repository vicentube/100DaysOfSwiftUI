// Test5View.swift
// Flashzilla
//
// Creado el 16/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct Test5View: View {
  let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
  @State private var counter = 0
  
  var body: some View {
    Text("Hello, World!")
      .onReceive(timer) { time in
        if counter == 5 {
          timer.upstream.connect().cancel()
        } else {
          print("The time is now \(time)")
        }
        
        counter += 1
      }
  }
}

struct Test5View_Previews: PreviewProvider {
  static var previews: some View {
    Test5View()
  }
}
