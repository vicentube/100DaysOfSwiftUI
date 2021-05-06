// ContactListView.swift
// PeopleNames
//
// Creado el 4/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct ContactListView: View  {
  @ObservedObject var store: ContactStore
  
  @State private var newContactImage: UIImage? = nil
  @State private var showingImagePicker = false
  @State private var showingAddView = false
  
  var body: some View {
    NavigationView {
      List {
        ForEach(store.contacts) { contact in
          NavigationLink(destination: ContactDetailView(contact: contact)) {
            ContactRowView(contact: contact)
          }
        }
      }
      .navigationBarTitle("Contacts")
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button(action: { showingImagePicker = true }) {
            Image(systemName: "plus")
          }
        }
      }
      .sheet(isPresented: $showingImagePicker, onDismiss: onImagePickerDismiss) {
        ImagePicker(image: $newContactImage)
      }
      .sheet(isPresented: $showingAddView) {
        AddContactView(store: store, image: $newContactImage)
      }
    }
  }
  
  func onImagePickerDismiss() {
    if newContactImage != nil {
      showingAddView = true
    }
  }
}

struct ContactListView_Previews: PreviewProvider {
  static let store = ContactStore(PreviewDataService())
  
  static var previews: some View {
    ContactListView(store: store)
  }
}
