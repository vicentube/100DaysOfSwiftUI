// Movie+CoreDataClass.swift
// CoreDataProject
//
// Creado el 12/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.
//

import Foundation
import CoreData

@objc(Movie)
public class Movie: NSManagedObject {

  public var wrappedTitle: String {
    title ?? "Unknown title"
  }
}
