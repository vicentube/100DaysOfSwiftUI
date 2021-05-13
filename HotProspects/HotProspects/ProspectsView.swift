// ProspectsView.swift
// HotProspects
//
// Creado el 11/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI
import CodeScanner

struct ProspectsView: View {
  let filter: FilterType
  
  @EnvironmentObject var prospects: Prospects
  
  @State private var isShowingScanner = false
  
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
          .contextMenu {
            Button(prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted" ) {
              prospects.toggle(prospect)
            }
          }
        }
      }
      .navigationBarTitle(title)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button(action: { isShowingScanner = true }) {
            Image(systemName: "qrcode.viewfinder")
            Text("Scan")
          }
        }
      }
      .sheet(isPresented: $isShowingScanner) {
        CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@hackingwithswift.com", completion: handleScan)
      }
    }
  }
  
  enum FilterType {
    case none, contacted, uncontacted
  }
  
  func handleScan(result: Result<String, CodeScannerView.ScanError>) {
    isShowingScanner = false
    switch result {
    case .success(let code):
      let details = code.components(separatedBy: "\n")
      guard details.count == 2 else { return }
      
      let person = Prospect()
      person.name = details[0]
      person.emailAddress = details[1]
      
      self.prospects.add(person)
    case .failure(let error):
      print("Scanning failed: \(error.localizedDescription)")
    }
  }
}

struct ProspectsView_Previews: PreviewProvider {
  static var previews: some View {
    ProspectsView(filter: .none)
  }
}
