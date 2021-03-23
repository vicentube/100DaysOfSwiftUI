// AstronautView.swift
// Moonshot
//
// Creado el 22/3/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct AstronautView: View {
  let astronaut: Astronaut
  let missions: [Mission]
  
  var body: some View {
    GeometryReader { geometry in
      ScrollView(.vertical) {
        VStack(alignment: .leading) {
          Image(self.astronaut.id)
            .resizable()
            .scaledToFit()
            .frame(width: geometry.size.width)
          Text("Crew member in:")
            .font(.headline)
            .padding(.horizontal)
          ForEach(missions) { mission in
            MissionRowView(mission: mission, names: nil)
              .padding(.horizontal)
          }
          Text(self.astronaut.description)
            .padding()
            .layoutPriority(1)
        }
      }
    }
    .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
  }
  
  init(astronaut: Astronaut) {
    self.astronaut = astronaut
    let allMissions: [Mission] = Bundle.main.decode("missions.json")
    self.missions = allMissions.filter( { mission in
      mission.crew.contains(where: { crewMember in
        crewMember.name == astronaut.id
      })
    })
  }
}

struct AstronautView_Previews: PreviewProvider {
  static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
  
  static var previews: some View {
    AstronautView(astronaut: astronauts[0])
  }
}
