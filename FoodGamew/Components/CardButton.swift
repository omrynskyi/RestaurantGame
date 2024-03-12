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
        Text(title)
            .frame(width: 330,height: 60)
            .background(backColor)
            .foregroundColor(frontColor)
            .font(.system(size: 18, weight: .bold))
            .cornerRadius(10)
    }
}

#Preview {
    CardButton(title: "Get Direction", backColor: .blue, frontColor: .white)
}
