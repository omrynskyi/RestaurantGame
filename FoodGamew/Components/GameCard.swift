//
//  GameCard.swift
//  FoodGamew
//
//  Created by Oleg Mrynskyi on 2/21/24.
//

import SwiftUI

struct GameCard: View {
    
    var name:String
    var gradient: [Color]
    
    var body: some View {
        Text(name)
            .frame(width: 330, height: 330,alignment: .center)
            .font(.system(size: 60, weight:.bold))
            .background(LinearGradient(gradient: Gradient(colors: gradient), startPoint: .topLeading, endPoint: .bottomTrailing))
            .foregroundColor(Color.white)
            .cornerRadius(30)
    }
}

#Preview {
    GameCard(name: "WOULD YOU RATHER",gradient: [Color.blue,Color.red,Color.purple])
}
