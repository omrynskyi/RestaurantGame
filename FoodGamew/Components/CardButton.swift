//
//  CardButton.swift
//  FoodGamew
//
//  Created by Oleg Mrynskyi on 2/27/24.
//

import SwiftUI

struct CardButton: View {
    var title: String
    var backColor: Color
    var frontColor: Color
    
    var body: some View {
        Text("Get Directions")
            .frame(width: 170,height: 70)
            .background(Color.green)
            .foregroundColor(.black)
            .font(.system(size: 20, weight: .bold))
            .cornerRadius(10)
    }
}

#Preview {
    CardButton(title: "Get Direction", backColor: .green, frontColor: .black)
}
