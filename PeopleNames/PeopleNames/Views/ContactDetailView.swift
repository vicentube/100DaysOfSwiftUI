// ContactDetailView.swift
// PeopleNames
//
// Creado el 6/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct ContactDetailView: View {
  let contact: Contact
  
  var body: some View {
    VStack {
      Image(contact: contact)
        .resizable()
        .scaledToFit()
        .frame(maxHeight: 250)
      Text(contact.notes)
        .padding()
      Spacer()
    }
    .padding(.vertical)
    .navigationBarTitle(contact.name)
  }
}

struct ContactDetailView_Previews: PreviewProvider {
  static let service = PreviewDataService()
  
  static var previews: some View {
    ContactDetailView(contact: service.contacts[0])
  }
}
