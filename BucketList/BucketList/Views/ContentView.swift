// ContentView.swift
// BucketList
//
// Creado el 24/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct ContentView: View {
  @StateObject private var vm = ContentViewModel()
  
  var body: some View {
    ZStack {
      if vm.isUnlocked {
        UnlockedView()
      } else {
        Button(action: vm.authenticate) {
          Text("Unlock Places")
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
        }
        .alert(isPresented: $vm.showingAlert) {
          Alert(title: Text("Error"), message: Text(vm.alertMessage), dismissButton: .default(Text("OK")))
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
