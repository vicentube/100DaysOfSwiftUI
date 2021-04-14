// FilteredListView.swift
// CoreDataProject
//
// Creado el 13/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct FilteredListView: View {
  var fetchRequest: FetchRequest<Singer>
  
  var singers: FetchedResults<Singer> { fetchRequest.wrappedValue }
  
  init(filter: String) {
    fetchRequest = FetchRequest<Singer>(entity: Singer.entity(), sortDescriptors: [], predicate: NSPredicate(format: "lastName BEGINSWITH %@", filter))
  }
  
  var body: some View {
    List(singers, id: \.self) { singer in
      Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
    }
  }
}
