// Persistence.swift
// FriendFace
//
// Creado el 16/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import CoreData

struct PersistenceController {
  static let shared = PersistenceController()
  
  //  static var preview: PersistenceController = {
  //    let result = PersistenceController(inMemory: true)
  //    let moc = result.container.viewContext
  //    for count in 0..<10 {
  //      let newItem = User(context: moc)
  //      newItem.id = UUID()
  //      newItem.isActive = Bool.random()
  //      newItem.name = "John Smith \(count)"
  //      newItem.age = Int16.random(in: 20...80)
  //      newItem.company = "Apple \(count)"
  //      newItem.email = "john.smith\(count)@apple.com"
  //      newItem.address = "Test Address \(count)"
  //      newItem.about = "Test about \(count)"
  //      newItem.registered = Date()
  //      newItem.tags = ["Test \(count)", "Tag \(count)"]
  //    }
  //    do {
  //      try moc.save()
  //    } catch {
  //      // Replace this implementation with code to handle the error appropriately.
  //      // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
  //      let nsError = error as NSError
  //      fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
  //    }
  //    return result
  //  }()
  
  let container: NSPersistentContainer
  
  init(inMemory: Bool = false) {
    container = NSPersistentContainer(name: "Model")
    if inMemory {
      container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
    }
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        
        /*
         Typical reasons for an error here include:
         * The parent directory does not exist, cannot be created, or disallows writing.
         * The persistent store is not accessible, due to permissions or data protection when the device is locked.
         * The device is out of space.
         * The store could not be migrated to the current model version.
         Check the error message to determine what the actual problem was.
         */
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    //container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
  }
  
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
      guard let decodedData = try? JSONDecoder().decode([UserData].self, from: data) else {
        print("Decoding JSON failed")
        return
      }
      let moc = container.viewContext
      for user in decodedData {
        createUser(user)
      }
      try? moc.save()
    }
    task.resume()
  }
  
  func createUser(_ user: UserData) {
    let newUser = User(context: container.viewContext)
    newUser.id = user.id
    newUser.isActive = user.isActive
    newUser.name = user.name
    newUser.age = user.age
    newUser.address = user.address
    newUser.email = user.email
    newUser.company = user.company
    newUser.about = user.about
    newUser.registered = user.registeredDate
    newUser.tags = user.tags
    for friend in user.friends {
      let newFriend = Friend(context: container.viewContext)
      newFriend.id = friend.id
      newFriend.name = friend.name
      newFriend.user = newUser
    }
  }
}
