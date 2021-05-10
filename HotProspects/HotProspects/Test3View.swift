// Test3View.swift
// HotProspects
//
// Creado el 9/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct Test3View: View {
  var body: some View {
    Text("Hello, World!")
      .onAppear {
        let url = URL(string: "https://www.apple.com")!
        URLSession.shared.dataTask(with: url) { data, response, error in
          if data != nil {
            print("We got data!")
          } else if let error = error {
            print(error.localizedDescription)
          }
        }.resume()
      }
  }
}

struct Test3View_Previews: PreviewProvider {
  static var previews: some View {
    Test3View()
  }
}
