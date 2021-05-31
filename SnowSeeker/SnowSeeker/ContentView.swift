// ContentView.swift
// SnowSeeker
//
// Creado el 26/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct ContentView: View {
  @StateObject private var favorites = Favorites()
  
  @State private var shownResorts = [Resort]()
  @State private var showingSettings = false
  @State private var settings = Settings()
  
  let resorts: [Resort] = Bundle.main.decode("resorts.json")
  
  var body: some View {
    NavigationView {
      List(shownResorts) { resort in
        NavigationLink(destination: ResortView(resort: resort)) {
          Image(resort.country)
            .resizable()
            .scaledToFill()
            .frame(width: 40, height: 25)
            .clipShape(
              RoundedRectangle(cornerRadius: 5)
            )
            .overlay(
              RoundedRectangle(cornerRadius: 5)
                .stroke(Color.black, lineWidth: 1)
            )
          
          VStack(alignment: .leading) {
            Text(resort.name)
              .font(.headline)
            Text("\(resort.runs) runs")
              .foregroundColor(.secondary)
          }
          .layoutPriority(1)
          
          if self.favorites.contains(resort) {
            Spacer()
            Image(systemName: "heart.fill")
              .accessibility(label: Text("This is a favorite resort"))
              .foregroundColor(.red)
          }
        }
      }
      .navigationBarTitle("Resorts")
      .toolbar { toolbar }
      
      WelcomeView()
    }
    .onAppear {
      shownResorts = resorts
    }
    .sheet(isPresented: $showingSettings) {
      SettingsView(
        resorts: resorts,
        sortedAndFiltered: $shownResorts,
        settings: $settings
      )
    }
    .environmentObject(favorites)
  }
  
  var toolbar: some ToolbarContent {
    ToolbarItem(placement: .navigationBarTrailing) {
      Button(action: { showingSettings = true }) {
        Image(systemName: "gearshape")
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

enum SortingField: CaseIterable {
  case none, name, country
  
  func title() -> String {
    switch self {
    case .none:
      return "None"
    case .name:
      return "By name"
    case .country:
      return "By country"
    }
  }
}
