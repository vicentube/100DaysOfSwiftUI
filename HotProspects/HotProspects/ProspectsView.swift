// ProspectsView.swift
// HotProspects
//
// Creado el 11/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct ProspectsView: View {
  let filter: FilterType
  
  @EnvironmentObject var prospects: Prospects
  
  var filteredProspects: [Prospect] {
    switch filter {
    case .none:
      return prospects.people
    case .contacted:
      return prospects.people.filter { $0.isContacted }
    case .uncontacted:
      return prospects.people.filter { !$0.isContacted }
    }
  }
  
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
      List {
        ForEach(filteredProspects) { prospect in
          VStack(alignment: .leading) {
            Text(prospect.name)
              .font(.headline)
            Text(prospect.emailAddress)
              .foregroundColor(.secondary)
          }
        }
      }
        .navigationBarTitle(title)
        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: {
              let prospect = Prospect()
              prospect.name = "Paul Hudson"
              prospect.emailAddress = "paul@hackingwithswift.com"
              prospects.people.append(prospect)
            }) {
              Image(systemName: "qrcode.viewfinder")
              Text("Scan")
            }
          }
        }
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
