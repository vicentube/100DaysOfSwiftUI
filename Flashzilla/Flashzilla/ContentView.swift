// ContentView.swift
// Flashzilla
//
// Creado el 17/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct ContentView: View {
  @State private var cards = [Card](repeating: Card.example, count: 10)
  
  var body: some View {
    ZStack {
      Image("background")
        .resizable()
        .scaledToFill()
        .edgesIgnoringSafeArea(.all)
      VStack {
        ZStack {
          ForEach(0..<cards.count, id: \.self) { index in
            CardView(card: Card.example)
              .stacked(at: index, in: cards.count)
          }
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

extension View {
  func stacked(at position: Int, in total: Int) -> some View {
    let offset = CGFloat(total - position)
    return self.offset(CGSize(width: 0, height: offset * 10))
  }
}
