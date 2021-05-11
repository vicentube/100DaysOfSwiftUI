// ProspectsView.swift
// HotProspects
//
// Creado el 11/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct ProspectsView: View {
  let filter: FilterType
  
  var title: String {
    switch filter {
    case .none:
      return "Everyone"
    case .contacted:
      return "Contacted people"
    case .uncontacted:
      return "Uncontacted people"
    }
  }
  
  var body: some View {
    NavigationView {
      Text("Hello, World!")
        .navigationBarTitle(title)
    }
  }
  
  enum FilterType {
    case none, contacted, uncontacted
  }
}

struct ProspectsView_Previews: PreviewProvider {
  static var previews: some View {
    ProspectsView(filter: .none)
  }
}
