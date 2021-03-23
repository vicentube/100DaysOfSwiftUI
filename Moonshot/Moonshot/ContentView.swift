// ContentView.swift
// Moonshot
//
// Creado el 20/3/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct ContentView: View {
  @State private var showLaunchDate = true
  
  let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
  let missions: [Mission] = Bundle.main.decode("missions.json")
  
  var body: some View {
    NavigationView {
      List(missions) { mission in
        NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
          MissionRowView(
            mission: mission,
            names: showLaunchDate ? nil : mission.crewNames(astronauts: astronauts))
        }
      }
      .navigationBarTitle("Moonshot")
      .navigationBarItems(
        trailing: Button(action: { showLaunchDate.toggle() }) {
          showLaunchDate ? Text("Show crew") : Text("Show launch date")
        })
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
