// Test8View.swift
// HotProspects
//
// Creado el 10/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI
import SamplePackage

struct Test8View: View {
  let possibleNumbers = Array(1...60)
  
  var results: String {
    let selected = possibleNumbers.random(7).sorted()
    let strings = selected.map(String.init)
    return strings.joined(separator: ", ")
  }
  
  var body: some View {
    Text(results)
  }
}

struct Test8View_Previews: PreviewProvider {
  static var previews: some View {
    Test8View()
  }
}
