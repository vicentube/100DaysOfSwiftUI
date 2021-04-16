// DetailView.swift
// FriendFace
//
// Creado el 16/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct DetailView: View {
  let user: User
  
  var body: some View {
    VStack {
      Text(user.name)
        .font(.title)
        .fontWeight(.bold)
        .padding()
      HStack {
        Image(systemName: "person.circle.fill")
          .font(.title)
          .foregroundColor(user.isActive ? .green : .red)
        Text(user.isActive ? "Active" : "Inactive")
      }
      Form {
        HStack {
          Text("Age")
          Spacer()
          Text("\(user.age)")
        }
        HStack {
          Text("Company")
          Spacer()
          Text(user.company)
        }
        HStack {
          Text("E-mail")
          Spacer()
          Text(user.email)
        }
        
        Section(header: Text("Address")) {
          Text(user.address.replacingOccurrences(of: ", ", with: "\n"))
        }
        
        Section(header: Text("About"), footer: Text("Registered: \(user.dateFormatted)")) {
          Text(user.about)
        }
        
        Section(header: Text("Tags")) {
          ScrollView(.horizontal) {
            HStack {
              ForEach(user.tags, id: \.self) { tag in
                Text(tag)
                  .font(.footnote)
                  .foregroundColor(.white)
                  .padding(5)
                  .background(Capsule().foregroundColor(.blue))
              }
            }
          }
        }
        
        Section(header: Text("Friends")) {
          List {
            ForEach(user.friends) { friend in
              Text(friend.name)
            }
          }
        }
      }
    }
    .navigationBarTitle("User details", displayMode: .inline)
  }
}

struct DetailView_Previews: PreviewProvider {
  static var previews: some View {
    DetailView(user: User.preview)
  }
}
