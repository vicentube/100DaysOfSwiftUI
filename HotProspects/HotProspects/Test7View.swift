// Test7View.swift
// HotProspects
//
// Creado el 10/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI
import UserNotifications

struct Test7View: View {
  var body: some View {
    VStack {
      Button("Request Permission") {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
          if success {
            print("All set!")
          } else if let error = error {
            print(error.localizedDescription)
          }
        }
      }
      
      Button("Schedule Notification") {
        let content = UNMutableNotificationContent()
        content.title = "Feed the cat"
        content.subtitle = "It looks hungry"
        content.sound = UNNotificationSound.default
        
        // show this notification five seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        // add our notification request
        UNUserNotificationCenter.current().add(request)
      }
    }
  }
}

struct Test7View_Previews: PreviewProvider {
  static var previews: some View {
    Test7View()
  }
}
