// Test1View.swift
// AccesibilityTP
//
// Creado el 30/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct Test1View: View {
  let pictures = [
    "ales-krivec-15949",
    "galina-n-189483",
    "kevin-horstmann-141705",
    "nicolas-tissot-335096"
  ]
  
  let labels = [
      "Tulips",
      "Frozen tree buds",
      "Sunflowers",
      "Fireworks",
  ]
  
  @State private var selectedPicture = Int.random(in: 0...3)
  
  var body: some View {
    Image(pictures[selectedPicture])
      .resizable()
      .scaledToFit()
      .onTapGesture {
        self.selectedPicture = Int.random(in: 0...3)
      }
      .accessibility(label: Text(labels[selectedPicture]))
      .accessibility(addTraits: .isButton)
      .accessibility(removeTraits: .isImage)
  }
}

struct Test1View_Previews: PreviewProvider {
  static var previews: some View {
    Test1View()
  }
}
