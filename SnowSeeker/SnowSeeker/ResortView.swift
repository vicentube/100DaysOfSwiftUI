// ResortView.swift
// SnowSeeker
//
// Creado el 27/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct ResortView: View {
  let resort: Resort
  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 0) {
        Image(decorative: resort.id)
          .resizable()
          .scaledToFit()
        
        Group {
          HStack {
            Spacer()
            ResortDetailsView(resort: resort)
            SkiDetailsView(resort: resort)
            Spacer()
          }
          .font(.headline)
          .foregroundColor(.secondary)
          .padding(.top)
          Text(resort.description)
            .padding(.vertical)
          
          Text("Facilities")
            .font(.headline)
          
          Text(ListFormatter.localizedString(byJoining: resort.facilities))
            .padding(.vertical)
        }
        .padding(.horizontal)
      }
    }
    .navigationBarTitle(Text("\(resort.name), \(resort.country)"), displayMode: .inline)
  }
}
struct ResortView_Previews: PreviewProvider {
  static var previews: some View {
    ResortView(resort: Resort.example)
  }
}
