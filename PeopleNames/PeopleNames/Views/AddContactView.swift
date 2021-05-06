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
  
  var imageView: Image {
    if let image = image {
      return Image(uiImage: image)
    } else {
      return Image(systemName: "photo.fill")
    }
  }
  
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
      imageView
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
    store.saveContact(contact: contact, image: image!)
    presentationMode.wrappedValue.dismiss()
  }
}

struct AddContactView_Previews: PreviewProvider {
  static let store = ContactStore(PreviewDataService())
  
  static var previews: some View {
    Group {
      AddContactView(store: store, image: .constant(PreviewDataService().getImage(index: 0)))
      AddContactView(store: store, image: .constant(nil))
    }
  }
}
