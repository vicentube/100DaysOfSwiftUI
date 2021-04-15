// DataStore.swift
// FriendFace
//
// Creado el 15/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

class DataStore: ObservableObject {
  @Published var users = [User]()
  
  func loadData() {
    guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
      print("Invalid URL")
      return
    }
    let request = URLRequest(url: url)
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data else {
        print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        return
      }
      guard let decodedData = try? JSONDecoder().decode([User].self, from: data) else {
        print("Decoding JSON failed")
        return
      }
      DispatchQueue.main.async {
        self.users = decodedData
      }
    }
    task.resume()
  }
}
