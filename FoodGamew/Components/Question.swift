//
//  Question.swift
//  FoodGamew
//
//  Created by Oleg Mrynskyi on 2/21/24.
//

import SwiftUI

struct Question: View {
    var question: String
    
    var body: some View {
        Text(question)
            .font(.system(size: 40,weight: .bold))
            .frame(width: 300, height: 300)
            .background(Color("AccentGray"))
            .cornerRadius(20)
            .padding(10)
    }
}

#Preview {
    Question(question: "Greek")
}
