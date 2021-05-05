// ContactListView.swift
// PeopleNames
//
// Creado el 4/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct ContactListView: View {
  @StateObject var vm: ContactListViewModel
  
  var body: some View {
    NavigationView {
      List {
        ForEach(vm.contacts) { contact in
          ContactRowView(contact: contact)
        }
      }
      .navigationBarTitle("Contacts")
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button(action: vm.onAddButtonAction) {
            Image(systemName: "plus")
          }
        }
      }
      .sheet(isPresented: $vm.showingImagePicker, onDismiss: vm.onImagePickerDismiss) {
        ImagePicker(image: $vm.newContactImage)
      }
      .sheet(isPresented: $vm.showingAddView) {
        Text("View for editing contact.")
      }
    }
  }
  
  init(dataService: DataServiceOption = .runtime) {
    self._vm = StateObject(wrappedValue: ContactListViewModel(dataService))
  }
}

struct ContactListView_Previews: PreviewProvider {
  static var previews: some View {
    ContactListView(dataService: .preview)
  }
}
