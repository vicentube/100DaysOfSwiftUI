// FilteredList.swift
// CoreDataProject
//
// Creado el 13/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI
import CoreData

struct FilteredList<T: NSManagedObject, Content: View>: View {
  var fetchRequest: FetchRequest<T>
  var singers: FetchedResults<T> { fetchRequest.wrappedValue }
  
  // this is our content closure; we'll call this once for each item in the list
  let content: (T) -> Content
  
  var body: some View {
    List(fetchRequest.wrappedValue, id: \.self) { singer in
      self.content(singer)
    }
  }
  
  init(sortDescriptors: [NSSortDescriptor],
       filterKey: String,
       filterValue: String,
       @ViewBuilder content: @escaping (T) -> Content) {
    fetchRequest = FetchRequest<T>(entity: T.entity(),
                                   sortDescriptors: sortDescriptors,
                                   predicate: NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue))
    self.content = content
  }
}

