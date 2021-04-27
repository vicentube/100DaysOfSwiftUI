// EditView.swift
// BucketList
//
// Creado el 27/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI
import MapKit

struct EditView: View {
  @Environment(\.presentationMode) var presentationMode
  @ObservedObject var placemark: MKPointAnnotation
  
  var body: some View {
    NavigationView {
      Form {
        Section {
          TextField("Place name", text: $placemark.wrappedTitle)
          TextField("Description", text: $placemark.wrappedSubtitle)
        }
      }
      .navigationBarTitle("Edit place")
      .navigationBarItems(trailing: Button("Done") {
        presentationMode.wrappedValue.dismiss()
      })
    }
  }
}
