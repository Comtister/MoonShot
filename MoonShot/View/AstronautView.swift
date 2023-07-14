//
//  AstronautView.swift
//  MoonShot
//
//  Created by Oguzhan Ozturk on 12.07.2023.
//

import SwiftUI

struct AstronautView: View {
    
    let astronaut: Astronout
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .center) {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                    .padding(.vertical)
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(.lightBackground)
                Text(astronaut.description)
                    .padding(.horizontal)
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    
    static let astronauts: [String: Astronout] = Bundle.main.getData(fileName: "astronauts.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts["aldrin"]!)
            .preferredColorScheme(.dark)
    }
}
