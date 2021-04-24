// Test2View.swift
// BucketList
//
// Creado el 24/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct Test2View: View {
  var body: some View {
    Text("Hello, World!")
      .onTapGesture {
        let str = "Test Message"
        let url = self.getDocumentsDirectory().appendingPathComponent("message.txt")
        
        do {
          try str.write(to: url, atomically: true, encoding: .utf8)
          let input = try String(contentsOf: url)
          print(input)
        } catch {
          print(error.localizedDescription)
        }
      }
  }
  
  func getDocumentsDirectory() -> URL {
    // find all possible documents directories for this user
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    // just send back the first one, which ought to be the only one
    return paths[0]
  }
}

struct Test2View_Previews: PreviewProvider {
  static var previews: some View {
    Test2View()
  }
}
