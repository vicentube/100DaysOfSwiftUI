// ContentView.swift
// Moonshot
//
// Creado el 20/3/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct CustomText: View {
  var text: String
  
  var body: some View {
    Text(text)
  }
  
  init(_ text: String) {
    print("Creating a new CustomText")
    self.text = text
  }
}

struct ContentView: View {
  var body: some View {
    NavigationView {
        List(0..<100) { row in
            NavigationLink(destination: Text("Detail \(row)")) {
                Text("Row \(row)")
            }
        }
        .navigationBarTitle("SwiftUI")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
