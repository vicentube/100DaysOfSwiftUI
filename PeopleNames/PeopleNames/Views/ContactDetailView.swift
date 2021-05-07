// ContactDetailView.swift
// PeopleNames
//
// Creado el 6/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI
import MapKit

struct ContactDetailView: View {
  let contact: Contact
  
  @StateObject private var locationFetcher = LocationFetcher()
  
  var body: some View {
    VStack {
      Image(contactImage: contact.image)
        .resizable()
        .scaledToFit()
        .frame(maxHeight: 250)
      Text(contact.notes)
        .padding()
      Spacer()
      Map(
        coordinateRegion: $locationFetcher.region,
        annotationItems: [contact],
        annotationContent: { (contact) -> MapMarker in
          MapMarker(coordinate: contact.location, tint: .green)
        }).edgesIgnoringSafeArea(.all)
    }
    .padding(.top)
    .navigationBarTitle(contact.name)
    .onAppear {
      locationFetcher.region.center = contact.location
    }
  }
}

struct ContactDetailView_Previews: PreviewProvider {
  static let service = PreviewDataService()
  
  static var previews: some View {
    ContactDetailView(contact: service.contacts[0])
  }
}
