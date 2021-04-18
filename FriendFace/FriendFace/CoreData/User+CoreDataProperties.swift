// User+CoreDataProperties.swift
// FriendFace
//
// Creado el 18/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.
//

import Foundation
import CoreData


extension User {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
    return NSFetchRequest<User>(entityName: "User")
  }
  
  @NSManaged public var id: UUID?
  @NSManaged public var isActive: Bool
  @NSManaged public var name: String?
  @NSManaged public var age: Int16
  @NSManaged public var address: String?
  @NSManaged public var company: String?
  @NSManaged public var email: String?
  @NSManaged public var about: String?
  @NSManaged public var registered: Date?
  @NSManaged public var tags: [String]?
  @NSManaged public var friends: NSSet?
  
  var wAbout: String { about ?? "N/A" }
  var wAddress: String { address ?? "N/A" }
  var wCompany: String { company ?? "N/A" }
  var wEmail: String { email ?? "N/A" }
  var wId: UUID { id ?? UUID() }
  var wName: String { name ?? "N/A" }
  var wRegistered: Date { registered ?? Date() }
  var wTags: [String] { tags ?? [] }
  
  var dateFormatted: String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    if let date = registered {
      return formatter.string(from: date)
    } else {
      return "N/A"
    }
  }
}

// MARK: Generated accessors for friends
extension User {
  
  @objc(addFriendsObject:)
  @NSManaged public func addToFriends(_ value: Friend)
  
  @objc(removeFriendsObject:)
  @NSManaged public func removeFromFriends(_ value: Friend)
  
  @objc(addFriends:)
  @NSManaged public func addToFriends(_ values: NSSet)
  
  @objc(removeFriends:)
  @NSManaged public func removeFromFriends(_ values: NSSet)
  
}

extension User : Identifiable {
  
}
