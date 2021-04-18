// DetailView.swift
// FriendFace
//
// Creado el 16/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct DetailView: View {
  @FetchRequest(
    entity: User.entity(),
    sortDescriptors: [NSSortDescriptor(keyPath: \User.name, ascending: true)]
  ) var users: FetchedResults<User>
  let user: User
  
  var body: some View {
    VStack {
      Text(user.wName)
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
          Text(user.wCompany)
        }
        HStack {
          Text("E-mail")
          Spacer()
          Text(user.wEmail)
        }
        
        Section(header: Text("Address")) {
          Text(user.wAddress.replacingOccurrences(of: ", ", with: "\n"))
        }
        
        Section(header: Text("About"), footer: Text("Registered: \(user.dateFormatted)")) {
          Text(user.wAbout)
        }
        
        Section(header: Text("Tags")) {
          ScrollView(.horizontal) {
            HStack {
              ForEach(user.wTags, id: \.self) { tag in
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
            ForEach(getFriendUsers()) { friend in
              NavigationLink(destination: DetailView(user: friend)) {
                UserRow(user: friend)
              }
            }
          }
        }
      }
    }
    .navigationBarTitle("User details", displayMode: .inline)
  }
  
  func getFriendUsers() -> [User] {
    var friendUsers = [User]()
    if let friends = user.friends as? Set<Friend> {
      for friend in friends {
        if let friendUser = users.first(where: { $0.id == friend.id }) {
          friendUsers.append(friendUser)
        }
      }
    }
    return friendUsers
  }
}

//struct DetailView_Previews: PreviewProvider {
//  static var previews: some View {
//    DetailView(user: User.preview)
//  }
//}
