// UserRow.swift
// FriendFace
//
// Creado el 16/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct UserRow: View {
  let user: User
  
  var body: some View {
    HStack {
      Image(systemName: "person.circle.fill")
        .foregroundColor(user.isActive ? .green : .red)
      VStack(alignment: .leading) {
        Text(user.wName)
        Text(user.wEmail)
          .font(.footnote)
          .foregroundColor(.secondary)
      }
    }
  }
}

//struct UserRow_Previews: PreviewProvider {
//  static var previews: some View {
//    UserRow(user: User.preview)
//  }
//}
