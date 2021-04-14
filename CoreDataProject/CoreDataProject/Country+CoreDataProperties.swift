// Country+CoreDataProperties.swift
// CoreDataProject
//
// Creado el 13/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.
//

import Foundation
import CoreData


extension Country {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
    return NSFetchRequest<Country>(entityName: "Country")
  }
  
  @NSManaged public var fullName: String?
  @NSManaged public var shortName: String?
  @NSManaged public var candy: NSSet?
  
  public var wrappedShortName: String {
    shortName ??  "Unknown Country"
  }
  
  public var wrappedFullName: String {
    fullName ?? "Unknown Country"
  }
  
  public var candyArray: [Candy] {
    let set = candy as? Set<Candy> ?? []
    return set.sorted {
      $0.wrappedName < $1.wrappedName
    }
  }
  
}

// MARK: Generated accessors for candy
extension Country {
  
  @objc(addCandyObject:)
  @NSManaged public func addToCandy(_ value: Candy)
  
  @objc(removeCandyObject:)
  @NSManaged public func removeFromCandy(_ value: Candy)
  
  @objc(addCandy:)
  @NSManaged public func addToCandy(_ values: NSSet)
  
  @objc(removeCandy:)
  @NSManaged public func removeFromCandy(_ values: NSSet)
  
}

extension Country : Identifiable {
  
}
