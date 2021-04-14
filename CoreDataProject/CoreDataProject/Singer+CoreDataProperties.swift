// Singer+CoreDataProperties.swift
// CoreDataProject
//
// Creado el 13/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.
//

import Foundation
import CoreData


extension Singer {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Singer> {
    return NSFetchRequest<Singer>(entityName: "Singer")
  }
  
  @NSManaged public var firstName: String?
  @NSManaged public var lastName: String?
  
  var wrappedFirstName: String {
    firstName ?? "Unknown"
  }
  
  var wrappedLastName: String {
    lastName ?? "Unknown"
  }
}

extension Singer : Identifiable {
  
}
