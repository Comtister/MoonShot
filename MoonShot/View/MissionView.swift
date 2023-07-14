//
//  MissionView.swift
//  MoonShot
//
//  Created by Oguzhan Ozturk on 12.07.2023.
//

import SwiftUI

struct CrewMember {
    let role: String
    let astranout: Astronout
}

struct MissionView: View {
    
    let mission: Mission
    let crew: [CrewMember]
    
    init(mission: Mission, astranouts: [String: Astronout]) {
        self.mission = mission
        self.crew = mission.crew.map({ member in
            if let crewMember = astranouts[member.name] {
                return CrewMember(role: member.role, astranout: crewMember)
            } else {
                fatalError("Missing \(member.name)")
            }
        })
    }
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView(.vertical,showsIndicators: false) {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: proxy.size.width * 0.6)
                        .padding(.top)
                    Text(mission.formattedLaunchDate)
                        .padding(.vertical)
                    VStack(alignment: .center) {
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.lightBackground)
                            .padding(.vertical)
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        Text(mission.description)
                    }
                    .padding(.bottom)
                    Text("Crew")
                        .font(.title.bold())
                        .padding([.bottom, .top], 5)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(crew, id: \.role) { astronaut in
                                NavigationLink {
                                    AstronautView(astronaut: astronaut.astranout)
                                } label: {
                                    Image(astronaut.astranout.id)
                                        .resizable()
                                        .frame(width: 104, height: 72)
                                        .clipShape(Capsule())
                                        .overlay(Capsule().strokeBorder(.white,lineWidth: 1))
                                    VStack(alignment: .leading) {
                                        Text(astronaut.astranout.name)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        Text(astronaut.role)
                                            .font(.headline)
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.bottom)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.getData(fileName: "missions.json")
    static let astronauts: [String: Astronout] = Bundle.main.getData(fileName: "astronauts.json")
    static var previews: some View {
        MissionView(mission: missions[0], astranouts: astronauts)
            .preferredColorScheme(.dark)
    }
}
