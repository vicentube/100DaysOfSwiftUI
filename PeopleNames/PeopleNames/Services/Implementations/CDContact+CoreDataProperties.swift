// CDContact+CoreDataProperties.swift
// PeopleNames
//
// Creado el 5/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.
//

import Foundation
import CoreData


extension CDContact {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<CDContact> {
    return NSFetchRequest<CDContact>(entityName: "CDContact")
  }
  
  @NSManaged public var id: UUID?
  @NSManaged public var name: String?
  @NSManaged public var notes: String?
  
}

extension CDContact : Identifiable {
  
}

extension CDContact {
  func convertToDto() -> Contact {
    Contact(
      id: id ?? UUID(),
      name: name ?? "",
      notes: notes ?? ""
    )
  }
  
  func fillFromDto(_ dto: Contact) {
    id = dto.id
    name = dto.name
    notes = dto.notes
  }
}
