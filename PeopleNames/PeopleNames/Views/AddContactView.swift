// AddContactView.swift
// PeopleNames
//
// Creado el 5/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct AddContactView: View {
  @ObservedObject var store: ContactStore
  @Binding var image: UIImage?
  
  @Environment(\.presentationMode) var presentationMode
  @State private var contact = Contact(id: UUID(), name: "", notes: "")
  
  var body: some View {
    VStack {
      HStack{
        Button(action: onCancelAction) {
          Text("Cancel")
        }
        Spacer()
        Text("Add contact")
          .font(.title)
          .fontWeight(.bold)
        Spacer()
        Button(action: onDoneAction) {
          Text("Done")
            .fontWeight(.bold)
        }
      }
      .padding()
      Image(contact: contact)
        .resizable()
        .scaledToFit()
        .frame(maxHeight: 250)
      Form {
        TextField("Name of contact", text: $contact.name)
        TextField("Notes", text: $contact.notes)
      }
    }
  }
  
  private func onCancelAction() {
    image = nil
    presentationMode.wrappedValue.dismiss()
  }
  
  private func onDoneAction() {
    guard image != nil else { return }
    contact.image = image
    store.saveContact(contact: contact)
    presentationMode.wrappedValue.dismiss()
  }
}

struct AddContactView_Previews: PreviewProvider {
  static let store = ContactStore(PreviewDataService())
  
  static var previews: some View {
    Group {
      AddContactView(store: store, image: .constant(store.contacts[0].image))
      AddContactView(store: store, image: .constant(nil))
    }
  }
}
