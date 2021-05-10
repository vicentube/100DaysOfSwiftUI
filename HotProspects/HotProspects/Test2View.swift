// Test2View.swift
// HotProspects
//
// Creado el 8/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct Test2View: View {
  @State private var selectedTab = 0
  
  var body: some View {
    TabView(selection: $selectedTab) {
      Text("Tab 1")
        .onTapGesture { selectedTab = 1 }
        .tabItem {
          Image(systemName: "star")
          Text("One")
        }
        .tag(0)
      Text("Tab 2")
        .tabItem {
          Image(systemName: "star.fill")
          Text("Two")
        }
        .tag(1)
    }
  }
}

struct Test2View_Previews: PreviewProvider {
  static var previews: some View {
    Test2View()
  }
}
