//
//  ListCellBackground.swift
//  MoonShot
//
//  Created by Oguzhan Ozturk on 14.07.2023.
//

import SwiftUI

struct ListCellBackground: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .padding(.vertical,1)
            .background(.black)
            .foregroundColor(.lightBackground)
    }
}

struct ListCellBackground_Previews: PreviewProvider {
    static var previews: some View {
        ListCellBackground()
    }
}
