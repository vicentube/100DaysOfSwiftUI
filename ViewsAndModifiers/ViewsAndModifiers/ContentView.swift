// ContentView.swift
// ViewsAndModifiers
//
// Creado el 4/3/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct GridStack<Content: View>: View {
  let rows: Int
  let columns: Int
  let content: (Int, Int) -> Content
  
  init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
      self.rows = rows
      self.columns = columns
      self.content = content
  }
  
  var body: some View {
    VStack {
      ForEach(0..<rows, id: \.self) { row in
        HStack {
          ForEach(0..<self.columns, id: \.self) { column in
            self.content(row, column)
          }
        }
      }
    }
  }
}

struct ProminentTitle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.largeTitle)
      .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
  }
}

extension View {
  func prominentTitle() -> some View {
    self.modifier(ProminentTitle())
  }
}

struct ContentView: View {
  var body: some View {
    GridStack(rows: 4, columns: 4) { row, col in
      Image(systemName: "\(row * 4 + col).circle")
      Text("R\(row) C\(col)")
    }
    .prominentTitle()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
