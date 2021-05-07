// ContactRowView.swift
// PeopleNames
//
// Creado el 4/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct ContactRowView: View {
  let contact: Contact
  
  var body: some View {
    HStack {
      Image(contactImage: contact.image)
        .resizable()
        .scaledToFill()
        .frame(width: 50, height: 50)
        .cornerRadius(10)
      VStack(alignment: .leading) {
        Text(contact.name)
        Text(contact.notes)
          .font(.footnote)
          .foregroundColor(.secondary)
      }
    }
  }
}

struct ContactRowView_Previews: PreviewProvider {
  static let store = ContactStore(PreviewDataService())
  
  static var previews: some View {
    Group {
      ContactRowView(contact: store.contacts[0])
        .previewLayout(.sizeThatFits)
      ContactRowView(contact: store.contacts[1])
        .previewLayout(.sizeThatFits)
    }
  }
}
