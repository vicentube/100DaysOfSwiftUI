// MissionRowView.swift
// Moonshot
//
// Creado el 22/3/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct MissionRowView: View {
  let mission: Mission
  
  var body: some View {
    HStack {
      Image(mission.image)
        .resizable()
        .scaledToFit()
        .frame(width: 44, height: 44)
      
      VStack(alignment: .leading) {
        Text(mission.displayName)
          .font(.headline)
        Text(mission.formattedLaunchDate)
      }
    }
  }
}

struct MissionRowView_Previews: PreviewProvider {
  static let missions: [Mission] = Bundle.main.decode("missions.json")
  static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
  
  static var previews: some View {
    MissionRowView(mission: missions[0])
  }
}
