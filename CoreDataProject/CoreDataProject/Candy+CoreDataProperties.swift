// Candy+CoreDataProperties.swift
// CoreDataProject
//
// Creado el 13/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.
//

import Foundation
import CoreData


extension Candy {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
    return NSFetchRequest<Candy>(entityName: "Candy")
  }
  
  @NSManaged public var name: String?
  @NSManaged public var origin: Country?
  
  public var wrappedName: String {
    name ?? "Unknown Candy"
  }
  
}

extension Candy : Identifiable {
  
}
