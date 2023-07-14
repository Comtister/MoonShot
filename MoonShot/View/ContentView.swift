//
//  ContentView.swift
//  MoonShot
//
//  Created by Oguzhan Ozturk on 7.07.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State var gridOrList = true
    
    let columns = [GridItem(.adaptive(minimum: 150))]
    
    let astronouts: [String: Astronout] = Bundle.main.getData(fileName: "astronauts.json")
    let missions: [Mission] = Bundle.main.getData(fileName: "missions.json")
    
    var body: some View {
        NavigationView {
            Group {
                if gridOrList {
                    GridView(missions: missions, astronauts: astronouts)
                } else {
                    ListView(missions: missions, astronauts: astronouts)
                }
            }
            .navigationTitle("MoonShot")
            .navigationBarTitleDisplayMode(.inline)
            //.preferredColorScheme(.dark)
            .toolbar {
                Toggle(isOn: $gridOrList, label: {
                    Text("Select")
                })
                .toggleStyle(.switch)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




struct GridView: View {
    
    private let columns = [GridItem(.adaptive(minimum: 150))]
    
    private let missions: [Mission]
    private let astronauts: [String: Astronout]
    
    init(missions: [Mission], astronauts: [String: Astronout]) {
        self.missions = missions
        self.astronauts = astronauts
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(missions) { mission in
                    NavigationLink {
                        MissionView(mission: mission, astranouts: astronauts)
                    } label: {
                        VStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                            VStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.5))
                            }
                            .frame(maxWidth: .infinity)
                            .background(.lightBackground)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(.lightBackground))
                    }
                    
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
        .navigationTitle("MoonShot")
        .background(.darkBackground)
        .preferredColorScheme(.dark)
    }
}

struct ListView: View {
    
    private let missions: [Mission]
    private let astranouts: [String: Astronout]
    
    init(missions: [Mission], astronauts: [String: Astronout]) {
            /// These could be anywhere before the list has loaded.
            UITableView.appearance().backgroundColor = .clear // tableview background
            UITableViewCell.appearance().backgroundColor = .clear // cell background
        self.missions = missions
        self.astranouts = astronauts
        }
    
    var body: some View {
        
        List(missions) { mission in
            NavigationLink {
                MissionView(mission: mission, astranouts: astranouts)
            } label: {
                HStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.title3)
                            .foregroundColor(.white)
                        Text(mission.formattedLaunchDate)
                            .foregroundColor(.white)
                    }
                }
                
            }
            .listRowSeparator(.hidden)
            .listRowBackground(ListCellBackground())
        }
        .preferredColorScheme(.dark)
        .background(Color.darkBackground)
        
    }
    
}

struct ListView_Previews: PreviewProvider {
    
    static let astronouts: [String: Astronout] = Bundle.main.getData(fileName: "astronauts.json")
    static let missions: [Mission] = Bundle.main.getData(fileName: "missions.json")
    
    static var previews: some View {
        ListView(missions: missions, astronauts: astronouts)
    }
}

struct GridView_Previews: PreviewProvider {
    
    static let astronouts: [String: Astronout] = Bundle.main.getData(fileName: "astronauts.json")
    static let missions: [Mission] = Bundle.main.getData(fileName: "missions.json")
    
    static var previews: some View {
        GridView(missions: missions, astronauts: astronouts)
    }
}

