// MissionView.swift
// Moonshot
//
// Creado el 22/3/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct MissionView: View {
  let mission: Mission
  let astronauts: [CrewMember]
  
  init(mission: Mission, astronauts: [Astronaut]) {
    self.mission = mission
    
    var matches = [CrewMember]()
    
    for member in mission.crew {
      if let match = astronauts.first(where: { $0.id == member.name }) {
        matches.append(CrewMember(role: member.role, astronaut: match))
      } else {
        fatalError("Missing \(member)")
      }
    }
    
    self.astronauts = matches
  }
  
  var body: some View {
    GeometryReader { geometry in
      ScrollView(.vertical) {
        VStack(spacing: 30) {
          Image(decorative: self.mission.image)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: geometry.size.width * 0.7)
            .shadow(color: .black, radius: 5, x: 0, y: 5)
            .padding(.top)
          Text(mission.formattedLaunchDate)
            .font(.title)
          Text(self.mission.description)
            .padding()
          ForEach(self.astronauts, id: \.role) { crewMember in
            let isCommander = crewMember.role.contains("Commander")
            NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut)) {
              HStack(spacing: 20) {
                Image(crewMember.astronaut.id)
                  .resizable()
                  .aspectRatio(contentMode: .fill)
                  .frame(width: 60, height: 60)
                  .clipShape(Circle())
                  .overlay(
                    Circle()
                      .stroke(isCommander ? Color.accentColor : Color.secondary, lineWidth: 5)
                      .frame(width: 72, height: 72))
                
                VStack(alignment: .leading) {
                  Text(crewMember.astronaut.name)
                    .font(.headline)
                  Text(crewMember.role)
                    .foregroundColor(isCommander ? .accentColor : .secondary)
                }
                
                Spacer()
              }
              .padding(.horizontal, 25)
            }
            .buttonStyle(PlainButtonStyle())
          }
          Spacer(minLength: 25)
        }
      }
    }
    .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
  }
  
  struct CrewMember {
    let role: String
    let astronaut: Astronaut
  }
}

struct MissionView_Previews: PreviewProvider {
  static let missions: [Mission] = Bundle.main.decode("missions.json")
  static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
  
  static var previews: some View {
    MissionView(mission: missions[0], astronauts: astronauts)
  }
}
