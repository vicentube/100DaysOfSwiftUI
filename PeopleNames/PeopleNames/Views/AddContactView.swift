// AddContactView.swift
// PeopleNames
//
// Creado el 5/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI
import MapKit

struct AddContactView: View {
  @ObservedObject var store: ContactStore
  @Binding var image: UIImage?
  
  @Environment(\.presentationMode) var presentationMode
  @StateObject private var locationFetcher = LocationFetcher()
  @State private var textName = ""
  @State private var textNotes = ""
  
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
      Image(contactImage: image)
        .resizable()
        .scaledToFit()
        .frame(maxHeight: 250)
      TextField("Name of contact", text: $textName)
        .padding()
        .textFieldStyle(RoundedBorderTextFieldStyle())
      TextField("Notes", text: $textNotes)
        .padding(.horizontal)
        .textFieldStyle(RoundedBorderTextFieldStyle())
      Map(
        coordinateRegion: $locationFetcher.region,
        showsUserLocation: true).edgesIgnoringSafeArea(.all)
    }
    .onAppear {
      locationFetcher.start()
    }
  }
  
  private func onCancelAction() {
    image = nil
    presentationMode.wrappedValue.dismiss()
  }
  
  private func onDoneAction() {
    guard image != nil else { return }
    let contact = Contact(
      id: UUID(),
      name: textName,
      notes: textNotes,
      image: image,
      location: locationFetcher.region.center)
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
