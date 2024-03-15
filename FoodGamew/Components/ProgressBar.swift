//
//  ProgressBar.swift
//  FoodGamew
//
//  Created by Oleg Mrynskyi on 3/14/24.
//

import SwiftUI

struct ProgressBar: View {
    var progress: Double
    var width: CGFloat
    var body: some View {
        ZStack(alignment: .leading){
            Rectangle().frame(width: width, height: 5)
                .foregroundColor(.secondary)
                .cornerRadius(10.0)
            Rectangle().frame(width: width * progress, height: 5)
                .foregroundColor(.primary)
                .cornerRadius(10.0)
            Image("asset_burger")
                .offset(x:-35)
                .offset(x:width * progress)
        }
    }
}

#Preview {
    ProgressBar(progress: 0.3, width: 300)
}
