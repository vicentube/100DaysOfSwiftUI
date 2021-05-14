// ProspectsView.swift
// HotProspects
//
// Creado el 11/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI
import UserNotifications
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
          RowView(prospect)
          .contextMenu {
            Button(prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted" ) {
              prospects.toggle(prospect)
            }
            if !prospect.isContacted {
              Button("Remind Me") {
                self.addNotification(for: prospect)
              }
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
  
  func RowView(_ prospect: Prospect) -> some View {
    HStack {
      VStack(alignment: .leading) {
        Text(prospect.name)
          .font(.headline)
        Text(prospect.emailAddress)
          .foregroundColor(.secondary)
      }
      Spacer()
      if filter == .none {
        Text(prospect.isContacted ? "✅" : "⚠️")
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
  
  func addNotification(for prospect: Prospect) {
    let center = UNUserNotificationCenter.current()
    
    let addRequest = {
      let content = UNMutableNotificationContent()
      content.title = "Contact \(prospect.name)"
      content.subtitle = prospect.emailAddress
      content.sound = UNNotificationSound.default
      
      var dateComponents = DateComponents()
      dateComponents.hour = 9
      let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
      
      let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
      center.add(request)
    }
    
    center.getNotificationSettings { settings in
      if settings.authorizationStatus == .authorized {
        addRequest()
      } else {
        center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
          if success {
            addRequest()
          } else {
            print("D'oh")
          }
        }
      }
    }
  }
}

struct ProspectsView_Previews: PreviewProvider {
  static var previews: some View {
    ProspectsView(filter: .none)
  }
}
